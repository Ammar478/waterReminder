import SwiftUI
import SwiftData

struct HydrationSummary: View {
//    @Query(sort:\DrinkHistory.drinkDate , animation: .easeIn) private var drinkHistory:[DrinkHistory]
    private var drinkHistory = generateMockDrinkHistories(for: 5, year: 2024)
    
    private enum Destinations: Hashable {
        case intake
        case goal
    }
    
    var histories: [DrinkHistory] {
        drinkHistory.groupedByWeeks()
    }
    
    @State private var selection: Destinations?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                List {
                    if !drinkHistory.isEmpty{
                        Section {
                            NavigationLink(value: Destinations.intake) {
                                WaterIntakeOverviewChart()
                            }
                        }
                        
                        Section {
                            NavigationLink(value: Destinations.goal) {
                                DrinkTypePieChartView()
                            }
                        }
                        
                        Section {
                            ForEach([
                                ("Total Intake with mL", String(format: "%.0f", histories.totalIntake()), Color.blue),
                                ("Average Goal", String(format: "%.0f", histories.averageGoal()), Color.green),
                                ("Achievement Rate", "\(histories.achievementRate()) %", Color.orange)
                            ], id: \.0) { label, value, color in
                                CardContent(label: label, value:  value, color: color)
                                    .listRowBackground(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)).padding(.vertical,6))
                                    .padding(10)
                                    .listRowSeparator(.hidden)
                            }
                            
                        }header: {
                            Text("Highlights")
                        }
                        
                        
                        
                    }else {
                        NoHistoryView()
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                
                
                
            }
            .padding(.top)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.pointer.opacity(0.3), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Reports")
            .navigationDestination(for: Destinations.self) { destination in
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
