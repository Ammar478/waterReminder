//
//  UserData.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import Foundation



extension UserProfile{
    static let userProfileSampleData:[UserProfile]=[
        UserProfile(name:"user",dailyWater: DailyWaterDrink(dailyDate: Date.now, dailyGoal: 3000, currentDrink: 0))
    ]
}
