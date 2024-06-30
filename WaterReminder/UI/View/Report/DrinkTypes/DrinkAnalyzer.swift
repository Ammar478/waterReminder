//
//  DrinkAnalyzer.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 30/06/2024.
//
import SwiftUI

protocol DrinkAnalyzer {
    
}

class DefaultDrinkAnalyzer: DrinkAnalyzer {
    func analyze(dataModel: [DrinkHistory]) -> DrinkAnalysis {
        guard !dataModel.isEmpty else {
            return DrinkAnalysis(bestDrinkType: nil, highestHydration: nil)
        }

        var counts: [DrinkTypes: Double] = [:]
        var totalHydration = 0.0
        var totalAmount = 0.0

        for history in dataModel {
            for record in history.drinkRecored {
                counts[record.drinkinfo.drinkType, default: 0] += record.drinkinfo.amount
                totalHydration += record.drinkinfo.amount * record.drinkinfo.hydrationLevel
                totalAmount += record.drinkinfo.amount
            }
        }

        let bestDrinkType = counts.max(by: { $0.value < $1.value })?.key
        let highestHydration = totalAmount > 0 ? (totalHydration / totalAmount * 100) : nil

        return DrinkAnalysis(bestDrinkType: bestDrinkType, highestHydration: highestHydration)
    }
}
