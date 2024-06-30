import SwiftUI
import SwiftData

struct HydrationSummary: View {
    @Query(sort:\DrinkHistory.drinkDate , animation: .easeIn) private var drinkHistory:[DrinkHistory]
    
    var histories: [DrinkHistory] {
        drinkHistory.groupedByWeeks()
    }
    
    var body: some View {
        NavigationStack {
             VStack(alignment: .leading, spacing: 20) {
                 if drinkHistory.isEmpty {
                     NoHistoryView()
                 } else {
                     HydrationListView(histories: histories)
                 }
             }
             .padding(.top)
             .customBackground()
             .navigationTitle("Reports")
             .navigationDestination(for: ReportDestinations.self) { destination in
                 switch destination {
                 case .intake:
                     WaterIntakeDetailsSummary()
                 case .goal:
                     DrinkTypeDetailsChart()
                 }
             }
         }
        
    }
    
}
