import SwiftUI
import SwiftData

struct HistoryView: View {
    @State private var selectedDateInfo: DrinkHistory?
    var user: UserProfile
    
    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                        
                        Section {
                            VStack(alignment: .leading, spacing: 14) {
                                
                                if let drink = selectedDateInfo, !drink.drinkRecored.isEmpty {
                                    VStack {
                                        HStack(alignment: .center, spacing: 10) {
                                            Text(drink.drinkDate.YearFormatter)
                                                .foregroundStyle(.secondary)
                                                .font(.caption)
                                            
                                            VStack {
                                                Divider()
                                            }
                                            
                                            HStack(spacing: 5) {
                                                Image(systemName: "trophy.fill")
                                                    .foregroundStyle(.orange)
                                                Text("\(drink.drinkGoal, specifier: "%.0f")")
                                            }
                                            .font(.caption)
                                            .bold(drink.isGoalAchefed)
                                            
                                            HStack(spacing: 5) {
                                                Image(systemName: "drop.fill")
                                                    .foregroundStyle(.pointer)
                                                
                                                Text("\(drink.currentDrink, specifier: "%.0f")")
                                            }
                                            .font(.caption)
                                            .bold(!drink.isGoalAchefed)
                                            
                                        }
                                    }
                                    VStack {
                                        ForEach(drink.drinkRecored, id: \.self) { item in
                                            IntakeRecoredElementView(intake: item)
                                                .deleteDisabled(false)
                                        }
                                    }
                                } else {
                                    NoHistoryView()
                                }
                            }
                            .padding()
                        } header: {
                            SelectDateView(listDate: user.sortedDrinkDates(), selectedDateProgress: $selectedDateInfo)
                                .background(Color.bgHeader)
                                .foregroundStyle(.white)
                                .shadow(radius: 2, y: 3)
                        }
                    }
                }
                .navigationTitle("History")
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.bgHeader, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .background(
                    Rectangle()
                        .fill(
                            LinearGradient(colors: [.bgMain, .clear, .pointer.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                        )
                        .ignoresSafeArea()
                )
            }
        }
    }
}

