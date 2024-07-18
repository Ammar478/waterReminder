//
//  DrinkHistoryData.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import Foundation
import SwiftData

@Model
final class DrinkHistory {
    @Attribute(.unique) var drinkDate:Date
    var drinkGoal:Double
    var currentDrink:Double
    var isGoalAchefed:Bool
    var drinkedProgress:Float
    var drinkRecored:[IntakeRecords]
    var userProfile:UserProfile?
    
    init(drinkDate: Date, drinkGoal: Double,currentDrink:Double, isGoalAchefed: Bool,drinkedProgress:Float ,drinkRecored: [IntakeRecords] = []) {
        self.drinkDate = drinkDate
        self.drinkGoal = drinkGoal
        self.currentDrink = currentDrink
        self.isGoalAchefed = isGoalAchefed
        self.drinkRecored = drinkRecored
        self.drinkedProgress = drinkedProgress
    }
}
