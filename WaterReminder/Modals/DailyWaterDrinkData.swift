//
//  DailyWaterDrinkData.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import Foundation
import SwiftData

@Model
final class DailyWaterDrink {
    @Attribute(.unique) var dailyDate:Date
    var dailyGoal:Double
    var currentDrink:Double
    var intakeRecords: [IntakeRecords]
    var userProfile:UserProfile?
    
    init(dailyDate: Date, dailyGoal: Double, currentDrink: Double,intakeRecords:[IntakeRecords] = []) {
        self.dailyDate = dailyDate
        self.dailyGoal = dailyGoal
        self.currentDrink = currentDrink
        self.intakeRecords = intakeRecords
        
    }
    
    func addIntake(amount: WaterIntake) {
        let newRecord = IntakeRecords(drinkTime: Date(), drinkinfo: amount)
        intakeRecords.append(newRecord)
        currentDrink += amount.amount
    }
    
    var progress: Float {
        Float(currentDrink / dailyGoal)
    }
    
    var sortedIntakes: [IntakeRecords] {
        intakeRecords.sorted(by: { $0.drinkTime > $1.drinkTime })
    }
    
    var isAchivedGoal:Bool{
        currentDrink >= dailyGoal
    }
    
    var metGoal: MetDailyGoal {
        return isAchivedGoal ? .achieved : .notAchieved
    }
    
}
