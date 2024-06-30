//
//  WaterIntakeBarChartView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 06/11/1445 AH.
//

import Charts
import SwiftUI
import SwiftData

struct WaterIntakeOverviewChart: View {
    @Query private var dataModel:[DrinkHistory]
    
    private var last7Days: [DrinkHistory] {
        
        
        return dataModel.last7Days
    }
    var statusWaterIntak:(percentageChange: Double, isIncreased: Bool){
        return dataModel.calculatePercentageChange()
    }
    
    private func averageWaterIntake(for days: [DrinkHistory]) -> Double {
        let totalIntake = days.reduce(0.0) { $0 + $1.currentDrink }
        return days.isEmpty ? 0 : totalIntake / Double(days.count)
    }
    
    private var totalWaterIntake: Double {
        
        last7Days.reduce(0) { $0 + $1.currentDrink }
    }
    
    private var statusWaterIntake: (percentageChange: Double, isIncreased: Bool) {
        dataModel.calculatePercentageChange()
    }
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Chart {
                ForEach(last7Days, id: \.drinkDate) { day in
                    BarMark(
                        x: .value("Date", day.drinkDate, unit: .day),
                        y: .value("Intake", day.currentDrink)
                    )
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                day.drinkDate.isToday ? .orange.opacity(0.5) : .pointer.opacity(0.5),
                                .clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    RectangleMark(
                        x: .value("Date", day.drinkDate, unit: .day),
                        y: .value("Intake", day.currentDrink),
                        width: .ratio(0.7),
                        height: .fixed(2)
                    )
                    .foregroundStyle(day.drinkDate.isToday ? .orange : .pointer)
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .padding()
            
            VStack(alignment: .leading) {
                Text("Water Intake in Past \(last7Days.count) Days")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .bold()
                    .padding([.bottom, .trailing], 4)
                
                HStack(alignment: .center, spacing: 3) {
                    Text("\(totalWaterIntake, specifier: "%.0f") mL")
                        .font(.callout)
                        .bold()
                    
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.\(statusWaterIntake.isIncreased ? "up" : "down")")
                        Text("\(statusWaterIntake.percentageChange, specifier: "%.0f") %")
                    }
                    .foregroundColor(statusWaterIntake.isIncreased ? .green : .red)
                    .font(.caption)
                }
                .padding(.bottom, 4)
                
                Text("Avg. \(averageWaterIntake(for: last7Days), specifier: "%.0f") mL")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        
    }
}
