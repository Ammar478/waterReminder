//
//  GoalOverview.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 02/11/1445 AH.
//

import SwiftUI


struct GoalOverview: View {
    var averageGoal:Double
    var drinkHistory:[DrinkHistory]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Average Goal")
                .font(.callout)
            .foregroundStyle(.sText)
            
            Text("\(averageGoal, format: .number) mL")
                .font(.title2.bold())
                .foregroundStyle(.pointer)
            
            GoalOverviewChart(overviewData: drinkHistory)
                .frame(height: 100)
        }
    }
}


#Preview {
    GoalOverview(averageGoal: 300, drinkHistory: [])
}
