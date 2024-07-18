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

    static let waterAll: [DrinkInformations] = [
        DrinkInformations(id: 1, amount: 100, drinkType: .water),
        DrinkInformations(id: 2, amount: 125, drinkType: .water),
        DrinkInformations(id: 3, amount: 150, drinkType: .water),
        DrinkInformations(id: 4, amount: 200, drinkType: .water),
        DrinkInformations(id: 5, amount: 250 , drinkType: .water),
        DrinkInformations(id: 6, amount: 300 , drinkType: .water),
        DrinkInformations(id: 7, amount: 350 , drinkType: .water),
        DrinkInformations(id: 8, amount: 400 , drinkType: .water),
        DrinkInformations(id: 9, amount: 500 , drinkType: .water),
        DrinkInformations(id: 10, amount: 600 , drinkType: .water)
    ]
    
    static let otherDrinks: [DrinkInformations] = [
        DrinkInformations(id: 11, amount: 240, drinkType: .tea),
        DrinkInformations(id: 12, amount: 240, drinkType: .coffee),
        DrinkInformations(id: 13, amount: 250, drinkType: .juices),
        DrinkInformations(id: 14, amount: 200, drinkType: .sparklingWater)
    ]
}
