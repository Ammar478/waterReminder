//
//  APIUserInfo.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 14/07/2024.
//

import Foundation

struct APIUserInfo: Codable {
    enum CodingKeys:String, CodingKey{
        case name
        case age
        case height
        case weight
        case gender
        case activityLevel = "activity_level"
        case dailyWater = "daily_water"
        case waterRecored = "water_recored"
    }
    let name :String
    let age:Int
    let height:Int
    let weight:Int
    let gender:Gender?
    let activityLevel:ActivityLevel?
    let dailyWater:DailyWaterDrink?
    let waterRecored:[DrinkHistory]
}
