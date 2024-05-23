//
//  DrinkWaterRecordData.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import Foundation


struct IntakeRecords:Codable, Hashable{
    var drinkTime:Date
    var drinkinfo:WaterIntake
}
