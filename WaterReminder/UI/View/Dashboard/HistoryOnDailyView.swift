//
//  HistoryOnDailyView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct HistoryOnDailyView: View {
    var dailyDrinkHistory: [IntakeRecords]
    
    init(dailyDrinkHistory: [IntakeRecords]) {
        self.dailyDrinkHistory = dailyDrinkHistory
    }
    
    var body: some View {
        VStack(alignment:.leading){
            Section{
                VStack{
                    if dailyDrinkHistory.isEmpty {
                        ContentUnAvailableUI(unAvailableContentDescription: "You have no history of water intake today")
                    } else {
                        
                        ForEach(dailyDrinkHistory,id:\.self) { intake in
                            IntakeRecoredElementView(intake: intake)
                            
                        }
                        
                    }
                    
                }
                
            }header: {
                HStack(alignment:.center,spacing: 7){
                    Image(systemName: "drop.circle.fill")
                    Text("Today Record")
                }
                .font(.callout)
                .foregroundStyle(.secondary)
                
                
            }
        }
    }
}

#Preview {
    HistoryOnDailyView(dailyDrinkHistory: [])
}
