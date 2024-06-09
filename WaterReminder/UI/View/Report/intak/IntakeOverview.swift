//
//  IntakeOverview.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 01/11/1445 AH.
//

import SwiftUI

struct IntakeOverview: View {
    var averageIntake:Double
    var drinkHistory:[DrinkHistory]
    
    var body: some View {
        let max = drinkHistory.maxTotalIntake(for: drinkHistory.groupedByWeeks())
        VStack(alignment: .leading) {
            Text("Hydration")
                .font(.callout)
                .bold()
            .foregroundStyle(.sText)
            
           Spacer()
            
            HStack(alignment:.bottom){
                VStack(alignment:.leading,spacing: 10){
                    VStack(alignment:.leading,spacing: 2){
                        Image(systemName: "flame.fill")
                            .font(.callout)
                            .foregroundStyle(.orange)
                        Text("Average Intake")
                            .font(.caption)
                            .foregroundStyle(.pointer)
                            .bold()
                    }
                    Text("\(averageIntake,specifier: "%.0f") mL")
                        .font(.title3)
                        .foregroundStyle(.orange)
                        .bold()
                    
                }
                
                Spacer()
                
                IntakeOverviewChart(overviewData: drinkHistory, markXLabel: "Day", markYLabel: "intake",maxYValye: max ?? 0)
                    .frame(height: 100)
            }
            
          
        }
        .padding(.vertical,10)
    }
}

#Preview {
    IntakeOverview(averageIntake: 1000000.3,drinkHistory: [])
}
