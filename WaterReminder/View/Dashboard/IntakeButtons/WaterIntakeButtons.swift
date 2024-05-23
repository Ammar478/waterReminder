//
//  WaterIntakeButtons.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct WaterIntakeButtons: View {
    @Environment(\.modelContext) var modelContext
    var dailyWater: DailyWaterDrink
    @Binding var cupSize: WaterIntake
    
    private func chnageCupSize(_ amount:WaterIntake){
        withAnimation(.easeIn(duration: 0.3)){
            cupSize = amount
        }
    }
    var body: some View {
        VStack(spacing:10){
            
                AddWater(cupSize: cupSize , action: addIntakeWater)
            
                
            
            HStack(alignment:.center,spacing: 30){
                ForEach(WaterIntakeSizes.waterAll.prefix(3)) { intake in
                    DrinkCupButton(intake: intake, selectedAmount: $cupSize) {
                        chnageCupSize(intake)
                    }
                }
                
                ChangeCupButton(cupSize: $cupSize,action: chnageCupSize)
            }
            
        }
    }
    private func addIntakeWater(){
        withAnimation{
            dailyWater.addIntake(amount: cupSize)
            try? modelContext.save()
        }
    }
}
