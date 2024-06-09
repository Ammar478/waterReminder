//
//  DrinkTypePieChartView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 06/11/1445 AH.
//

import Charts
import SwiftUI
import SwiftData


struct DrinkTypePieChartView: View {
//    @Query private var dataModel:[DrinkHistory]
    let dataModel = generateMockDrinkHistories(for: 5, year: 2024)

    
    
    
    private var drinkTypeCounts: [(type: DrinkTypes, amount: Double)] {
        var counts: [DrinkTypes: Double] = [:]
        
        for history in dataModel {
            for record in history.drinkRecored {
                counts[record.drinkinfo.drinkType, default: 0] += record.drinkinfo.amount
            }
        }
        
        
        return counts.map { (key: $0.key, value: $0.value) }
            .sorted { $0.value > $1.value }
            .map { (type: $0.key, amount: $0.value) }
    }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Drink Types Distribution")
                    .font(.headline)
                    .padding([.top, .leading, .trailing])
                
                Chart(drinkTypeCounts,id: \.type) {entry in
                    
                    BarMark(
                        x: .value("Amount", entry.amount),
                        y: .value("Drink Type", entry.type.title)
                    )
                    .cornerRadius(8)
                    .foregroundStyle(.linearGradient(colors: [.clear ,entry.type.color.opacity(0.8)], startPoint: .leading, endPoint: .trailing))
                    
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
            }
            .chartForegroundStyleScale([
                DrinkTypes.tea.title: DrinkTypes.tea.color,
                DrinkTypes.water.title: DrinkTypes.water.color,
                DrinkTypes.coffee.title: DrinkTypes.coffee.color,
                DrinkTypes.sparklingWater.title: DrinkTypes.sparklingWater.color,
                DrinkTypes.juices.title: DrinkTypes.juices.color
            ])
            .chartLegend(position: .trailing)
            .padding([.leading, .trailing, .bottom])
        }
    
    
}
