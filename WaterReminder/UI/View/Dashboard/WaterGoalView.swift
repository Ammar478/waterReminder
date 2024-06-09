//
//  WaterGoalView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct WaterGoalView: View {
    var dailyWater: DailyWaterDrink
    
    var body: some View {
        VStack {
            HStack {
                Text("Today's Goal")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
                Image(systemName: "trophy")
                    .foregroundStyle(Color.orange)
                    .shadow(radius: 1)
                    .font(.headline)
            }
            Text("Drink \(dailyWater.dailyGoal.formatted(.number)) mL")
                .font(.title2)
                .foregroundStyle(.teal)
                .bold()
        }

    }
}

#Preview {
    WaterGoalView(dailyWater: DailyWaterDrink(dailyDate: Date.now, dailyGoal: 3000, currentDrink: 2000))
}
