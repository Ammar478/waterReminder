//
//  WeeklySummaryView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 01/11/1445 AH.
//

import Charts
import SwiftUI

struct IntakeOverviewChart: View {
    var overviewData:[DrinkHistory]
    var markXLabel:String
    var markYLabel:String
    var maxYValye:Double
    
    var body: some View {
        Chart(overviewData, id: \.drinkDate) {
            BarMark(
                x: .value(markXLabel, $0.drinkDate.firstLetterOfWeekDay),
                y: .value(markYLabel, $0.currentDrink)
            )
            .clipShape(.rect(cornerRadius: 3))
        }
        .chartYAxis(.hidden)
        .chartYScale(domain:0...(maxYValye + 2000) )
        .foregroundStyle(.pointer)
        .aspectRatio(1, contentMode: .fit)
        
    }
}

