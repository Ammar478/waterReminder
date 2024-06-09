//
//  GoalOverviewChart.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 02/11/1445 AH.
//

import SwiftUI

import Charts
import SwiftUI

struct GoalOverviewChart: View {
    var overviewData:[DrinkHistory]

    
    var body: some View {
        Chart(overviewData, id: \.drinkDate) {
            BarMark(
                x: .value("Day", $0.drinkDate.firstLetterOfWeekDay),
                y: .value("Goal", $0.drinkGoal)
            )
        }
        .chartYAxis(.hidden)
        .foregroundStyle(.gray)
        .aspectRatio(1, contentMode: .fit)
    }
}



#Preview {
    GoalOverviewChart(overviewData: [])
}
