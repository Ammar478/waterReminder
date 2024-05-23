//
//  UserProfileData.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import Foundation


extension UserProfile{
    
    static var sampleUserProfile:UserProfile {
        let newUser = UserProfile(name: "name1")
        let newIntakeRecords:[IntakeRecords] = [IntakeRecords(drinkTime: Date.now, amountOfDrink: 50),
                                                IntakeRecords(drinkTime: Date.now, amountOfDrink: 50),
                                                IntakeRecords(drinkTime: Date.now, amountOfDrink: 50),
                                                IntakeRecords(drinkTime: Date.now, amountOfDrink: 50)]
        let newIntakeHistoryRecords:[DrinkHistory] = [
            DrinkHistory(drinkDate: Date.now, drinkGoal: 1000, isGoalAchefed: true,drinkedProgress: 0.5, drinkRecored: newIntakeRecords)
        ]
        newUser.dailyWater = DailyWaterDrink(dailyDate: Date.now, dailyGoal: 1000, currentDrink: 200, intakeRecords: newIntakeRecords)
        newUser.waterRecored = newIntakeHistoryRecords
        
        return newUser
    }
    
}
