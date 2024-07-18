//
//  DrinkIntakeDetailsModel.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import Foundation

protocol DrinkIntakeDetailsModel:ObservableObject {
    var last30Days: [DrinkHistory] {get}
    var dailyAverage:Double {get }
    var weekdayAverage:Double {get}
    var weekendAverage:Double {get}
    var bestDay:DrinkHistory? {get}
    
    @MainActor
    func dismiss()
}

final class _DrinkIntakeDetailsModel:DrinkIntakeDetailsModel {
    private  let api :API
    private let localStorage:LocalStorage
    private let dismissAction:@MainActor () -> Void
    
    private var drinkHistories:[DrinkHistory] {
        willSet {Task {@MainActor in self.objectWillChange.send()}}
    }
    
    var last30Days: [DrinkHistory] {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -29, to: Date())!
        return drinkHistories.filter { $0.drinkDate >= startDate }
    }
    
    var dailyAverage: Double {
        guard !self.last30Days.isEmpty else { return 0 }
        let total = last30Days.reduce(0) { $0 + $1.currentDrink }
        return total / Double(last30Days.count)
    }
    
    var weekdayAverage: Double {
        let weekdays = self.last30Days.filter { !Calendar.current.isDateInWeekend($0.drinkDate) }
        guard !weekdays.isEmpty else { return 0 }
        let total = weekdays.reduce(0) { $0 + $1.currentDrink }
        return total / Double(weekdays.count)
    }
    
    var weekendAverage: Double {
        let weekends = self.last30Days.filter { Calendar.current.isDateInWeekend($0.drinkDate) }
        guard !weekends.isEmpty else { return 0 }
        let total = weekends.reduce(0) { $0 + $1.currentDrink }
        return total / Double(weekends.count)
    }
    
    var bestDay: DrinkHistory? {
        self.last30Days.max(by: { $0.currentDrink < $1.currentDrink })
    }
    
    init(api: API, localStorage: LocalStorage, dismissAction: @escaping () -> Void, drinkHistories: [DrinkHistory]) {
        self.api = api
        self.localStorage = localStorage
        self.dismissAction = dismissAction
        self.drinkHistories = drinkHistories
    }
    
    @MainActor
    func dismiss() {self.dismissAction()}
}

