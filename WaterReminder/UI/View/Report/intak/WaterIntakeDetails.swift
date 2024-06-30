//
//  HydrationSummaryView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 06/11/1445 AH.
//

import SwiftUI
import SwiftData

struct WaterIntakeDetailsSummary: View {
    @Query private var dataModel: [DrinkHistory]
    @State private var selectedStatistic: Statistic? = .defaultValue
    
    private var calculator: WaterIntakeSummaryCalculator {
        WaterIntakeSummaryCalculator(dataModel: dataModel)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                VStack(alignment: .leading) {
                    header
                    HydrationSummaryChart(
                        data: calculator.last30Days,
                        selectedStatistic: selectedStatistic ?? .defaultValue,
                        selectedValue: selectedValue(for: selectedStatistic ?? .defaultValue),
                        bestDay: calculator.bestDay
                    )
                    .padding([.leading, .trailing, .bottom])
                }
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .padding()
                
                VStack(alignment: .leading) {
                    statistics
                }
                .navigationTitle("Hydration Tracker")
            }
        }
        .customBackground()
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            Text("Hydration Summary")
                .font(.headline)
                .foregroundStyle(.sText)
                .padding([.top, .leading, .trailing])
            
            Text("\(calculator.last30Days.reduce(0) { $0 + $1.currentDrink }, specifier: "%.0f") ml in Last \(dataModel.count) Days")
                .font(.title3)
                .bold()
                .foregroundStyle(.pointer)
                .padding([.leading, .bottom, .trailing])
        }
    }
    
    private var statistics: some View {
        VStack(spacing: 10) {
            SummaryStatisticView(
                title: "Daily Average",
                value: String(format: "%.0f ml", calculator.dailyAverage),
                isSelected: selectedStatistic == .dailyAverage
            )
            .onTapGesture {
                selectedStatistic = .dailyAverage
            }
            SummaryStatisticView(
                title: "Weekday Average",
                value: String(format: "%.0f ml", calculator.weekdayAverage),
                isSelected: selectedStatistic == .weekdayAverage
            )
            .onTapGesture {
                selectedStatistic = .weekdayAverage
            }
            SummaryStatisticView(
                title: "Weekend Average",
                value: String(format: "%.0f ml", calculator.weekendAverage),
                isSelected: selectedStatistic == .weekendAverage
            )
            .onTapGesture {
                selectedStatistic = .weekendAverage
            }
            if let bestDay = calculator.bestDay {
                SummaryStatisticView(
                    title: "Best Hydration Day",
                    value: "\(bestDay.drinkDate.formattedDate)",
                    isSelected: selectedStatistic == .bestDay
                )
                .onTapGesture {
                    selectedStatistic = .bestDay
                }
            }
        }
        .padding([.leading, .trailing, .bottom])
    }
    
    private func selectedValue(for statistic: Statistic) -> Double {
        switch statistic {
        case .dailyAverage:
            return calculator.dailyAverage
        case .weekdayAverage:
            return calculator.weekdayAverage
        case .weekendAverage:
            return calculator.weekendAverage
        case .bestDay:
            return calculator.bestDay?.currentDrink ?? 0
        case .defaultValue:
            return 0
        }
    }
}
