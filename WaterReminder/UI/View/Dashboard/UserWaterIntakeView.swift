//
//  UserWaterIntakeView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct UserWaterIntakeView: View {
    var user: UserProfile
    @Binding var cupSize: WaterIntake
    
    var body: some View {
            if let dailyWater = user.dailyWater {
                VStack(spacing: 30) {
                    GaugeProgressView(progress: dailyWater.progress, amountDrinked: dailyWater.currentDrink,dailyGoal: dailyWater.dailyGoal)
                        .frame(width: 180, height: 180)
                        .padding()
                    
                    WaterIntakeView(dailyWater: dailyWater, cupSize: $cupSize)

                    HistoryOnDailyView(dailyWater: dailyWater)
                        .padding(.horizontal,10)
                    
                }
            }
        }
}

