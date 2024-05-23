//
//  HydrationDetials.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 05/11/1445 AH.
//

import Charts
import SwiftUI
import SwiftData


struct HydrationDetials: View {
    //    @Query private var drinkHistoryData:[DrinkHistory]
    let drinkHistoryData =  generateMockDrinkHistories(for: 5, year: 2024)
    
    @State private var selectedTimeRange: TimeRange = .lastWeek
    @State private var  scrollPositionStart:Date
    
    init(){
        self.scrollPositionStart = self.drinkHistoryData.last!.drinkDate.addingTimeInterval(-1 * 3600 * 24 * 30)
    }
    var scrollPositionEnd: Date {
        scrollPositionStart.addingTimeInterval(3600 * 24 * 30)
    }
    
    var scrollPositionString: String {
        scrollPositionStart.formatted(.dateTime.month().day())
    }
    
    var scrollPositionEndString: String {
        scrollPositionEnd.formatted(.dateTime.month().day().year())
    }
    
    var filteredData:  [DrinkHistory] {
        
        switch selectedTimeRange {
        case .lastWeek:
            return  drinkHistoryData.groupedByWeeks()
        case .last30Days:
            return   drinkHistoryData.groupedByMonths()
        case .last12Months:
            return  drinkHistoryData.groupedByYears()
        }
    }
    
    
    var body: some View {
        List{
            VStack(alignment: .leading) {
                TimeRangePickerView(value: $selectedTimeRange)
                    .pickerStyle(SegmentedPickerStyle())
                
                WaterIntakeOverviewChart()
                
                
                    .frame(maxWidth: .infinity)
            }
            .navigationTitle("Hydration")
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}








