//
//  DrinkHistoryRecord.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 01/11/1445 AH.
//

import Foundation

extension Array where Element == DrinkHistory {
    
    var last7Days: [DrinkHistory] {
        let calendar = Calendar.current
        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -6, to: endDate)!
        
        return self.filter { $0.drinkDate >= startDate && $0.drinkDate <= endDate }
    }
    
    
    func calculatePercentageChange() -> (percentageChange: Double, isIncreased: Bool) {
        let recentDays = last7Days.prefix(6)
        let previousDays = self.filter { $0.drinkDate < last7Days.first?.drinkDate ?? Date() }.suffix(6)
        
        let recentAverage = averageWaterIntake(for: Array(recentDays))
        let previousAverage = averageWaterIntake(for: Array(previousDays))
        
        guard previousAverage > 0 else {
            return (0, false) // Avoid division by zero
        }
        
        let percentageChange = ((recentAverage - previousAverage) / previousAverage) * 100
        let isIncreased = percentageChange > 0
        return (percentageChange, isIncreased)
    }
    
    // Helper method to calculate the average water intake for a given array of DrinkHistory
    private func averageWaterIntake(for days: [DrinkHistory]) -> Double {
        let totalIntake = days.reduce(0.0) { $0 + $1.currentDrink }
        return days.isEmpty ? 0 : totalIntake / Double(days.count)
    }
    
    
    func groupedByWeeks() -> [DrinkHistory] {
        let grouped = Dictionary(grouping: self, by: { Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: $0.drinkDate)) ?? $0.drinkDate })
        return Array(grouped.values.flatMap { $0 })
    }
    
    func groupedByMonths() -> [DrinkHistory] {
        let grouped = Dictionary(grouping: self, by: { Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: $0.drinkDate)) ?? $0.drinkDate })
        return Array(grouped.values.flatMap { $0 })
    }
    
    func groupedByYears() -> [DrinkHistory] {
        let grouped = Dictionary(grouping: self, by: { Calendar.current.date(from: Calendar.current.dateComponents([.year], from: $0.drinkDate)) ?? $0.drinkDate })
        return Array(grouped.values.flatMap { $0 })
    }
    
    func totalIntake() -> Double {
        self.reduce(0) { $0 + $1.currentDrink }
    }
    
    func averageIntake() ->Double{
        guard !self.isEmpty else { return 0 }
        return self.reduce(0){$0 + $1.currentDrink} / Double(self.count)
    }
    
    func averageGoal() -> Double {
        guard !self.isEmpty else { return 0 }
        return self.reduce(0) { $0 + $1.drinkGoal } / Double(self.count)
    }
    
    func achievementRate() -> Int {
        guard !self.isEmpty else { return 0 }
        let achievedDays = self.filter { $0.isGoalAchefed }.count
        return Int((Double(achievedDays) / Double(self.count)) * 100)
    }
    
    func maxIntakeDay() -> DrinkHistory? {
        self.max(by: { $0.currentDrink < $1.currentDrink })
    }
    
    func minIntakeDay() -> DrinkHistory? {
        self.min(by: { $0.currentDrink < $1.currentDrink })
    }
    
    
    
    func longestStreak() -> Int {
        var longestStreak = 0
        var currentStreak = 0
        
        for i in 1..<self.count {
            if Calendar.current.isDate(self[i-1].drinkDate, inSameDayAs: self[i].drinkDate.addingTimeInterval(-86400)) && self[i-1].isGoalAchefed {
                currentStreak += 1
            } else {
                currentStreak = 1
            }
            longestStreak = Swift.max(longestStreak, currentStreak)
        }
        return longestStreak
    }
    
    func weekdayVsWeekendIntake() -> (weekdayAverage: Double, weekendAverage: Double) {
        let weekdays = self.filter {
            let weekday = Calendar.current.component(.weekday, from: $0.drinkDate)
            return weekday != 1 && weekday != 7
        }
        let weekends = self.filter {
            let weekday = Calendar.current.component(.weekday, from: $0.drinkDate)
            return weekday == 1 || weekday == 7
        }
        return (weekdays.averageIntake(), weekends.averageIntake())
    }
    
    func maxTotalIntake(for groupedData: [DrinkHistory]) ->   Double? {
            var maxIntake: Double = 0
                let totalIntake = groupedData.reduce(0) { $0 + $1.currentDrink }
                if totalIntake > maxIntake {
                    maxIntake = totalIntake
            }

            return  maxIntake
        }

}
