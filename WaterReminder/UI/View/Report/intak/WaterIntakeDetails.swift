//
//  HydrationSummaryView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 06/11/1445 AH.
//

import SwiftUI
import SwiftData

struct WaterIntakeDetailsSummary<VM:DrinkIntakeDetailsModel>: View {
    @State var viewModel:VM
    
    init(viewModel:VM){
        self._viewModel = .init(initialValue: viewModel)
    }
    
    @State private var selectedStatistic: Statistic? = .defaultValue
    

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                VStack(alignment: .leading) {
                    header
                    HydrationSummaryChart(
                        data: viewModel.last30Days,
                        selectedStatistic: selectedStatistic ?? .defaultValue,
                        selectedValue: selectedValue(for: selectedStatistic ?? .defaultValue),
                        bestDay: viewModel.bestDay
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
        .toolbar{
            ToolbarItem(placement: .navigation) {
                Button {
                    viewModel.dismiss()
                } label: {
                    Label("Back", systemImage: "chevron.backward")
                }
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            Text("Hydration Summary")
                .font(.headline)
                .foregroundStyle(.sText)
                .padding([.top, .leading, .trailing])
            
            Text("\(viewModel.last30Days.reduce(0) { $0 + $1.currentDrink }, specifier: "%.0f") ml in Last \(viewModel.last30Days.count) Days")
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
                value: String(format: "%.0f ml", viewModel.dailyAverage),
                isSelected: selectedStatistic == .dailyAverage
            )
            .onTapGesture {
                selectedStatistic = .dailyAverage
            }
            SummaryStatisticView(
                title: "Weekday Average",
                value: String(format: "%.0f ml", viewModel.weekdayAverage),
                isSelected: selectedStatistic == .weekdayAverage
            )
            .onTapGesture {
                selectedStatistic = .weekdayAverage
            }
            SummaryStatisticView(
                title: "Weekend Average",
                value: String(format: "%.0f ml", viewModel.weekendAverage),
                isSelected: selectedStatistic == .weekendAverage
            )
            .onTapGesture {
                selectedStatistic = .weekendAverage
            }
            if let bestDay = viewModel.bestDay {
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
            return viewModel.dailyAverage
        case .weekdayAverage:
            return viewModel.weekdayAverage
        case .weekendAverage:
            return viewModel.weekendAverage
        case .bestDay:
            return viewModel.bestDay?.currentDrink ?? 0
        case .defaultValue:
            return 0
        }
    }
}
