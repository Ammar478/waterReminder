//
//  DrinkTypeDetailsModel.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import Foundation

protocol DrinkTypeDetailsModel:ObservableObject {
    var last30Days: [DrinkHistory] {get}

    @MainActor
    func dismiss()
}

final class _DrinkTypeDetailsModel:DrinkTypeDetailsModel  {
    private  let api :API
    private let localStorage:LocalStorage
    private let dismissAction:@MainActor () -> Void
    
    private var drinkHistories:[DrinkHistory] {
        willSet {Task {@MainActor in self.objectWillChange.send()}}
    }
    
    init(api: API, localStorage: LocalStorage, dismissAction:@MainActor @escaping () -> Void, drinkHistories: [DrinkHistory]) {
        self.api = api
        self.localStorage = localStorage
        self.dismissAction = dismissAction
        self.drinkHistories = drinkHistories
    }
    
    var last30Days: [DrinkHistory] {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -29, to: Date())!
        return drinkHistories.filter { $0.drinkDate >= startDate }
    }
    
    @MainActor
    func dismiss() {self.dismissAction()}
}
