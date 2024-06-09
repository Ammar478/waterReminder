//
//  HydrationSummaryView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 06/11/1445 AH.
//

import Charts
import SwiftUI
import SwiftData

struct WaterIntakeDetailsSummary: View {
//            @Query private var dataModel:[DrinkHistory]
    let dataModel =  generateMockDrinkHistories(for: 5, year: 2024)
    
    @State private var selectedStatistic: Statistic? = .defaultValue
    
    private var last30Days: [DrinkHistory] {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -29, to: Date())!
        return dataModel.filter { $0.drinkDate >= startDate }
    }
    
    private var dailyAverage: Double {
        guard !last30Days.isEmpty else { return 0 }
        let total = last30Days.reduce(0) { $0 + $1.currentDrink }
        return total / Double(last30Days.count)
    }
    
    private var weekdayAverage: Double {
        let weekdays = last30Days.filter { !Calendar.current.isDateInWeekend($0.drinkDate) }
        guard !weekdays.isEmpty else { return 0 }
        let total = weekdays.reduce(0) { $0 + $1.currentDrink }
        return total / Double(weekdays.count)
    }
    
    private var weekendAverage: Double {
        let weekends = last30Days.filter { Calendar.current.isDateInWeekend($0.drinkDate) }
        guard !weekends.isEmpty else { return 0 }
        let total = weekends.reduce(0) { $0 + $1.currentDrink }
        return total / Double(weekends.count)
    }
    
    private var bestDay: DrinkHistory? {
        last30Days.max(by: { $0.currentDrink < $1.currentDrink })
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                VStack(alignment: .leading) {
                    Text("Hydration Summary")
                        .font(.headline)
                        .foregroundStyle(.sText)
                        .padding([.top, .leading, .trailing])
                    
                    Text("\(last30Days.reduce(0) { $0 + $1.currentDrink }, specifier: "%.0f") ml in Last \(dataModel.count) Days")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.pointer)
                        .padding([.leading, .bottom, .trailing])
                    
                    Chart {
                        ForEach(last30Days, id: \.drinkDate) { day in
                            BarMark(
                                x: .value("Date", day.drinkDate, unit: .day),
                                y: .value("Intake", day.currentDrink)
                            )
                            .foregroundStyle(getForegroundStyle(for: day))
                        }
                        if let selected = selectedStatistic,selected != .defaultValue {
                            RuleMark(
                                y: .value("Average", selectedValue(for: selected))
                            )
                            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundStyle(Color.orange)
                            
                            .annotation(position: .top, alignment: .leading) {
                                Text("\(selected.title): \(selectedValue(for: selected), specifier: "%.0f") ml")
                                    .font(.headline)
                                    .foregroundColor(.p1)
                                    .bold()
                                
                                
                            }
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .day,count: 7)) { value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.day().month())
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                    
                    
                }
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .padding()
                
                VStack(alignment: .leading){
                    VStack(spacing: 10) {
                        SummaryStatisticView(
                            title: "Daily Average",
                            value: String(format: "%.0f ml", dailyAverage),
                            isSelected: selectedStatistic == .dailyAverage
                        )
                        .onTapGesture {
                            selectedStatistic = .dailyAverage
                        }
                        SummaryStatisticView(
                            title: "Weekday Average",
                            value: String(format: "%.0f ml", weekdayAverage),
                            isSelected: selectedStatistic == .weekdayAverage
                        )
                        .onTapGesture {
                            selectedStatistic = .weekdayAverage
                        }
                        SummaryStatisticView(
                            title: "Weekend Average",
                            value: String(format: "%.0f ml", weekendAverage),
                            isSelected: selectedStatistic == .weekendAverage
                        )
                        .onTapGesture {
                            selectedStatistic = .weekendAverage
                        }
                        if let bestDay = bestDay {
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
                .navigationTitle("Hydration Tracker")
                
            }
        }
        .customBackground()
    }
    
    private func selectedValue(for statistic: Statistic) -> Double {
        switch statistic {
        case .dailyAverage:
            return dailyAverage
        case .weekdayAverage:
            return weekdayAverage
        case .weekendAverage:
            return weekendAverage
        case .bestDay:
            return bestDay?.currentDrink ?? 0
        case .defaultValue:
            return 0
        }
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
    
    enum Statistic {
        case dailyAverage
        case weekdayAverage
        case weekendAverage
        case bestDay
        case defaultValue
        
        var title: String {
            switch self {
            case .dailyAverage:
                return "Daily Average"
            case .weekdayAverage:
                return "Weekday Average"
            case .weekendAverage:
                return "Weekend Average"
            case .bestDay:
                return "Best Hydration Day"
            case .defaultValue:
                return ""
            }
        }
    }
}

struct SummaryStatisticView: View {
    let title: String
    let value: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(isSelected ? Color.orange : Color(.systemGray5)))
    }
}
