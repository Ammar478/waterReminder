//
//  userProfile.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 22/10/1445 AH.
//

import Foundation
import SwiftData
import CoreML

@Model
final class UserProfile {
    var name:String
    var age:Int
    var height:Int
    var weight:Int
    var gender:Gender.RawValue
    var activityLevel:ActivityLevel.RawValue
    
    var dailyWater:DailyWaterDrink?
    var waterRecored:[DrinkHistory] = []
    
    init(name: String, age: Int, height: Int, weight: Int, gender: Gender = .male, activityLevel: ActivityLevel = .active) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.gender = gender.rawValue
        self.activityLevel = activityLevel.rawValue
        
    }
    
    func addNewUser() {
        guard dailyWater == nil else {
            return
        }
        if let newGoal = genrateNewDailyGoal(IntakeAmount: 0,
                                             DailyGoal: 0,
                                             metGoal: .notAchieved) {
            let newWater = DailyWaterDrink(dailyDate: Date(),
                                           dailyGoal:newGoal,
                                           currentDrink: 0,
                                           intakeRecords: [])
            dailyWater = newWater
        }
    }
    
    
    func addNewDailyHistoryRecord(nextDate:Date) {
        guard let water = dailyWater,isDifferentDay(water.dailyDate, from: nextDate) else { return }
        waterRecored.append(DrinkHistory(drinkDate: water.dailyDate,
                                         drinkGoal: water.dailyGoal,
                                         currentDrink: water.currentDrink,
                                         isGoalAchefed: water.isAchivedGoal,
                                         drinkedProgress: water.progress,
                                         drinkRecored: water.intakeRecords))
        
        
        if let newGoal = genrateNewDailyGoal(IntakeAmount: Int64(water.currentDrink),
                                             DailyGoal: Int64(water.dailyGoal),
                                             metGoal: water.metGoal) {
            let newWater = DailyWaterDrink(dailyDate: nextDate,
                                           dailyGoal: Double(newGoal),
                                           currentDrink: 0,
                                           intakeRecords: [])
            dailyWater = newWater
            newWater.userProfile = self
        }
    }
    
    
    func genrateNewDailyGoal(IntakeAmount:Int64,DailyGoal:Int64,metGoal:MetDailyGoal) -> Double? {
        do {
            let config = MLModelConfiguration()
            let model = try GeneraterHydrationWaterGoals(configuration: config)
            
            let output = try model.prediction(age: Int64(self.age),
                                              weight: Int64(self.weight),
                                              sex: self.gender,
                                              activity_level: self.activityLevel,
                                              initial_goal: DailyGoal,
                                              intake: IntakeAmount,
                                              is_goal_met: metGoal.status)
            return output.next_day_goal
        } catch {
            print("Error predicting model output: \(error)")
            return nil
        }
    }
}

enum ActivityLevel:String, Codable,CaseIterable, Identifiable{
    case mostlySitting = "Mostly sitting"
    case active = "Active"
    case veryActive = "Very active"
    
    var id: String { self.rawValue }
    
}

enum Gender:String , Codable, CaseIterable, Identifiable{
    case male = "male"
    case female = "female"
    
    var id: String { self.rawValue }
    
}


extension UserProfile {
    func sortedDrinkDates() -> [DrinkHistory] {
        waterRecored.map { $0 }.sorted(by: { $0.drinkDate < $1.drinkDate })
    }
    
    func record(for date: Date) -> DrinkHistory {
        return waterRecored.first { Calendar.current.isDate($0.drinkDate, inSameDayAs: date) }
        ?? DrinkHistory(drinkDate: date, drinkGoal: 0.0,currentDrink: 0, isGoalAchefed: false, drinkedProgress: 0.0)
    }
    
}


