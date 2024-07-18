//
//  UserWaterIntakeView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct UserWaterIntakeView: View {
    var user: UserProfile
    @Binding var cupSize: DrinkInformations
    
    var body: some View {
        
        VStack(spacing: 30) {
            GaugeProgressView(progress: user.dailyDrink.progress, amountDrinked: user.dailyDrink.currentDrink,dailyGoal: user.dailyDrink.dailyGoal)
                .frame(width: 180, height: 180)
                .padding()
            
            WaterIntakeView(dailyWater: user.dailyDrink, cupSize: $cupSize)
            
            HistoryOnDailyView(dailyWater: user.dailyDrink)
                .padding(.horizontal,10)
            
        }
    }
    
}

