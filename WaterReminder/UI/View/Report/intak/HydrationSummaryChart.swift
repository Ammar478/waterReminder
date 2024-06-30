//
//  HydrationSummaryChart.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 30/06/2024.
//

import SwiftUI
import Charts

struct HydrationSummaryChart: View {
    let data: [DrinkHistory]
    let selectedStatistic: Statistic
    let selectedValue: Double
    let bestDay: DrinkHistory?
    
    var body: some View {
        Chart {
            ForEach(data, id: \.drinkDate) { day in
                BarMark(
                    x: .value("Date", day.drinkDate, unit: .day),
                    y: .value("Intake", day.currentDrink)
                )
                .foregroundStyle(getForegroundStyle(for: day))
            }
            if selectedStatistic != .defaultValue {
                RuleMark(
                    y: .value("Average", selectedValue)
                )
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundStyle(Color.orange)
                .annotation(position: .top, alignment: .leading) {
                    Text("\(selectedStatistic.title): \(selectedValue, specifier: "%.0f") ml")
                        .font(.headline)
                        .foregroundColor(.p1)
                        .bold()
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 7)) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.day().month())
            }
        }
        .padding([.leading, .trailing, .bottom])
    }
    
    private func getForegroundStyle(for day: DrinkHistory) -> Color {
        if selectedStatistic == .bestDay, bestDay?.drinkDate == day.drinkDate {
            return .pointer.opacity(0.5)
        } else if selectedStatistic == .weekdayAverage, !Calendar.current.isDateInWeekend(day.drinkDate) {
            return .pointer.opacity(0.5)
        } else if selectedStatistic == .weekendAverage, Calendar.current.isDateInWeekend(day.drinkDate) {
            return .pointer.opacity(0.5)
        } else {
            return .gray.opacity(0.5) // Default color
        }
    }
}
