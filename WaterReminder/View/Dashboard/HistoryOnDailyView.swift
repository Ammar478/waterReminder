//
//  HistoryOnDailyView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct HistoryOnDailyView: View {
    var dailyWater: DailyWaterDrink
    
    func delteItem(at offsets:IndexSet){
        dailyWater.intakeRecords.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack(alignment:.leading){
            Section{
                VStack{
                    if dailyWater.intakeRecords.isEmpty {
                        ContentUnAvailableUI(unAvailableContentDescription: "You have no history of water intake today")
                    } else {
                        
                        ForEach(dailyWater.sortedIntakes,id:\.self) { intake in
                            IntakeRecoredElementView(intake: intake)
                                
                        }
                        
                        .onDelete(perform:delteItem)
                    }
                    
                }
              
                
            }header: {
                
                
                Text("Today Record")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                
            }
        }
    }
}

#Preview {
    HistoryOnDailyView(dailyWater: DailyWaterDrink(dailyDate: Date.now, dailyGoal: 3000, currentDrink: 2000))
}
