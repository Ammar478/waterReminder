//
//  WaterIntakeButtons.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI
import SwiftData

struct WaterIntakeView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var waterIntakeModel: WaterIntakeModel
    @Binding var cupSize: WaterIntake
    
    init(dailyWater: DailyWaterDrink, cupSize: Binding<WaterIntake>) {
        _waterIntakeModel = StateObject(wrappedValue: WaterIntakeModel(dailyWater: dailyWater))
        _cupSize = cupSize
    }
    
    var body: some View {
        VStack(spacing: 10) {
            AddWater(cupSize: cupSize,
                     action: 
                        { waterIntakeModel.addIntakeWater(amount: cupSize,modelContext: self.modelContext) })
            
            WaterIntakeSelectionView(cupSize: $cupSize,
                                     changeCupSize:
                                        { waterIntakeModel.changeCupSize($0, cupSize: $cupSize) })
        }
    }
}
