//
//  WaterIntakeSummaryCalculator.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 30/06/2024.
//

import SwiftUI

struct WaterIntakeSummaryCalculator {
    let dataModel: [DrinkHistory]
    
    var last30Days: [DrinkHistory] {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -29, to: Date())!
        return dataModel.filter { $0.drinkDate >= startDate }
    }
    
    var dailyAverage: Double {
        guard !last30Days.isEmpty else { return 0 }
        let total = last30Days.reduce(0) { $0 + $1.currentDrink }
        return total / Double(last30Days.count)
    }
    
    var weekdayAverage: Double {
        let weekdays = last30Days.filter { !Calendar.current.isDateInWeekend($0.drinkDate) }
        guard !weekdays.isEmpty else { return 0 }
        let total = weekdays.reduce(0) { $0 + $1.currentDrink }
        return total / Double(weekdays.count)
    }
    
    var weekendAverage: Double {
        let weekends = last30Days.filter { Calendar.current.isDateInWeekend($0.drinkDate) }
        guard !weekends.isEmpty else { return 0 }
        let total = weekends.reduce(0) { $0 + $1.currentDrink }
        return total / Double(weekends.count)
    }
    
    var bestDay: DrinkHistory? {
        last30Days.max(by: { $0.currentDrink < $1.currentDrink })
    }
}
