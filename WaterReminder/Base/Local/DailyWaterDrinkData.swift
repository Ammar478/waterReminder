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
}

extension DailyWaterDrink{
    static let defaultDrinkAmount:Int64 = 0
    static let defaultPreviuseGoal:Int64 = 0
    static let defalutGoal = 3000.00
    static let defaultDate = Date()
    static let defaultCurrentDrink:Double = 0
}
