//
//  HealthImpactsFactors.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 07/11/1445 AH.
//

import Foundation

struct HealthImpactFactors {
    var hydrationLevel: Double
    var calorieContent: Double
    var caffeineContent: Double
    var sugarContent: Double
    var vitaminContent: Double
    var mineralContent: Double
}

let predefinedHealthImpactFactors: [DrinkTypes: HealthImpactFactors] = [
    .water: HealthImpactFactors(hydrationLevel: 5, calorieContent: 0, caffeineContent: 0, sugarContent: 0, vitaminContent: 1, mineralContent: 3),
    .tea: HealthImpactFactors(hydrationLevel: 4, calorieContent: 1, caffeineContent: 2, sugarContent: 1, vitaminContent: 2, mineralContent: 2),
    .coffee: HealthImpactFactors(hydrationLevel: 3, calorieContent: 2, caffeineContent: 5, sugarContent: 0, vitaminContent: 1, mineralContent: 1),
    .sparklingWater: HealthImpactFactors(hydrationLevel: 4, calorieContent: 0, caffeineContent: 0, sugarContent: 0, vitaminContent: 1, mineralContent: 3),
    .juices: HealthImpactFactors(hydrationLevel: 3, calorieContent: 3, caffeineContent: 0, sugarContent: 5, vitaminContent: 4, mineralContent: 2)
]
