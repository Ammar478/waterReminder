//
//  WaterIntakeSizes.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 25/10/1445 AH.
//

import Foundation

struct WaterIntakeSizes: Identifiable {
    var id: Int
    var amount: Double

    static let waterAll: [WaterIntake] = [
        WaterIntake(id: 1, amount: 100, drinkType: .water),
        WaterIntake(id: 2, amount: 125, drinkType: .water),
        WaterIntake(id: 3, amount: 150, drinkType: .water),
        WaterIntake(id: 4, amount: 200, drinkType: .water),
        WaterIntake(id: 5, amount: 250 , drinkType: .water),
        WaterIntake(id: 6, amount: 300 , drinkType: .water),
        WaterIntake(id: 7, amount: 350 , drinkType: .water),
        WaterIntake(id: 8, amount: 400 , drinkType: .water),
        WaterIntake(id: 9, amount: 500 , drinkType: .water),
        WaterIntake(id: 10, amount: 600 , drinkType: .water)
    ]
    
    static let otherDrinks: [WaterIntake] = [
        WaterIntake(id: 11, amount: 240, drinkType: .tea),
        WaterIntake(id: 12, amount: 240, drinkType: .coffee),
        WaterIntake(id: 13, amount: 250, drinkType: .juices),
        WaterIntake(id: 14, amount: 200, drinkType: .sparklingWater)
    ]
}
