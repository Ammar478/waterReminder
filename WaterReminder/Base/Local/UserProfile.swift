//
//  userProfile.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 22/10/1445 AH.
//

import Foundation
import SwiftData

@Model
final class UserProfile {
    @Attribute(.unique) var userId:UUID = UUID()
    var name:String = ""
    var age:Int
    var height:Int
    var weight:Int
    var gender:Gender
    var activityLevel:ActivityLevel
    
    var dailyDrink:DailyWaterDrink?
    var waterRecored:[DrinkHistory] = []
    
    init(
         name: String = "",
         age:Int,
         height:Int ,
         weight:Int,
         gender: Gender,
         activityLevel: ActivityLevel,
         dailyDrink:DailyWaterDrink? = nil
    ) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.gender = gender
        self.activityLevel = activityLevel
        self.dailyDrink =  dailyDrink
        
    }
}
    
//    func addNewDailyHistoryRecord(nextDate:Date) {
//        guard let water = dailyDrink,isDifferentDay(water.dailyDate, from: nextDate) else { return }
//        waterRecored.append(DrinkHistory(drinkDate: water.dailyDate,
//                                         drinkGoal: water.dailyGoal,
//                                         currentDrink: water.currentDrink,
//                                         isGoalAchefed: water.isAchivedGoal,
//                                         drinkedProgress: water.progress,
//                                         drinkRecored: water.intakeRecords))
//        
//        
//        if let newGoal = genrateNewDailyGoal(IntakeAmount: Int64(water.currentDrink),
//                                             DailyGoal: Int64(water.dailyGoal),
//                                             metGoal: water.metGoal) {
//            let newWater = DailyWaterDrink(dailyDate: nextDate,
//                                           dailyGoal: Double(newGoal),
//                                           currentDrink: 0,
//                                           intakeRecords: [])
//            dailyDrink = newWater
//            newWater.userProfile = self
//        }
//    }
    
    



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


