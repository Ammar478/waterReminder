//
//  AchievementRateOverview.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 02/11/1445 AH.
//

import SwiftUI

struct AchievementRateOverview: View {
    var rate:Double
    var drinkHistory:[DrinkHistory]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Acheivement Rate")
                .font(.callout)
            .foregroundStyle(.sText)
            
            Text("\(rate)")
                .font(.title2.bold())
                .foregroundStyle(.pointer)
            
            AchievementOverviewChart(overviewData: drinkHistory)
                .frame(height: 100)
        }
    }
}
