//
//  WaterIntakeModel.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import Foundation
import SwiftUI
import SwiftData

final class WaterIntakeModel: ObservableObject, WaterIntakeManaging {    
    var dailyWater: DailyWaterDrink
    
    init(dailyWater: DailyWaterDrink) {
        self.dailyWater = dailyWater
    }
    
    func addIntakeWater(amount: WaterIntake , modelContext:ModelContext) {
        withAnimation {
            dailyWater.addIntake(amount: amount)
            try? modelContext.save()
        }
    }
    
    func changeCupSize(_ amount: WaterIntake, cupSize: Binding<WaterIntake>) {
        withAnimation(.easeIn(duration: 0.3)) {
            cupSize.wrappedValue = amount
        }
    }
}
