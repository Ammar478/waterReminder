//
//  WaterSelectionModel.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import SwiftUI

struct WaterIntake: Identifiable, Codable, Hashable {
    var id: Int
    var amount: Double
    var drinkType: DrinkTypes
    
    var hydrationLevel: Double {
        switch drinkType {
        case .water:
            return 1.0
        case .tea:
            return 0.9
        case .coffee:
            return 0.95
        case .sparklingWater:
            return 1.0
        case .juices:
            return 0.8
        }
    }

    var sugarContent: Double {
        switch drinkType {
        case .water, .tea, .coffee, .sparklingWater:
            return 0.0
        case .juices:
            return 10.0 // grams per 100ml
        }
    }
}
