//
//  DrinkAnalysis.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 07/11/1445 AH.
//

import Foundation

struct DrinkAnalysis {
    let bestDrinkType: DrinkTypes?
    let bestDrinkPercentage: Int?
    let highestHydration: Double?
    let averageSugar: Double?
    let progress: Double?
    let startDay: Date?
    let endDay: Date?
}

func analyzeDrinks(dataModel: [DrinkHistory]) -> DrinkAnalysis {
    guard !dataModel.isEmpty else {
        return DrinkAnalysis(bestDrinkType: nil, bestDrinkPercentage: nil, highestHydration: nil, averageSugar: nil, progress: nil, startDay: nil, endDay: nil)
    }

    var counts: [DrinkTypes: Double] = [:]
    var totalHydration = 0.0
    var totalSugar = 0.0
    var totalAmount = 0.0
    let calendar = Calendar.current
    let now = Date()

    // Get the dynamic number of days based on the count of drinkHistory
    let dynamicDays = dataModel.count
    let dynamicDaysAgo = calendar.date(byAdding: .day, value: -dynamicDays, to: now)!

    let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
    let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!

    var startAmount = 0.0
    var endAmount = 0.0

    for history in dataModel {
        for record in history.drinkRecored {
            let drinkTime = record.drinkTime
            let drinkInfo = record.drinkinfo

            if drinkTime >= dynamicDaysAgo {
                counts[drinkInfo.drinkType, default: 0] += drinkInfo.amount
                totalHydration += drinkInfo.amount * drinkInfo.hydrationLevel
                totalSugar += drinkInfo.amount * (drinkInfo.sugarContent / 100)
                totalAmount += drinkInfo.amount
            }

            if drinkTime >= startOfMonth && drinkTime <= endOfMonth {
                if calendar.isDate(drinkTime, inSameDayAs: startOfMonth) {
                    startAmount += drinkInfo.amount
                }
                if calendar.isDate(drinkTime, inSameDayAs: endOfMonth) {
                    endAmount += drinkInfo.amount
                }
            }
        }
    }

    let totalAmountLastDynamicDays = counts.values.reduce(0, +)

    let bestDrinkType = counts.max(by: { $0.value < $1.value })?.key
    let bestDrinkPercentage = totalAmountLastDynamicDays > 0 ? Int((counts[bestDrinkType!]! / totalAmountLastDynamicDays * 100).rounded()) : nil

    let highestHydration = totalAmount > 0 ? (totalHydration / totalAmount * 100) : nil
    let averageSugar = totalAmount > 0 ? (totalSugar / totalAmount * 100) : nil

    let progress = totalAmount > 0 ? (endAmount - startAmount) / totalAmount * 100 : nil

    return DrinkAnalysis(
        bestDrinkType: bestDrinkType,
        bestDrinkPercentage: bestDrinkPercentage,
        highestHydration: highestHydration,
        averageSugar: averageSugar,
        progress: progress,
        startDay: startOfMonth,
        endDay: endOfMonth
    )
}
