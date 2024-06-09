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
                                        SectionHistoryHeaderView(drinkDate: drink.drinkDate,
                                                                 drinkGoal: drink.drinkGoal,
                                                                 currentDrink: drink.currentDrink,
                                                                 isGoalAchived: drink.isGoalAchefed)
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
                .customBackground()
            }
        }
    }
}

