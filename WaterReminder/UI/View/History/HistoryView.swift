import SwiftUI

struct HistoryView<VM:HistoryViewModel>: View {
    @StateObject var viewModel:VM
    @State private var selectedDateInfo: DrinkHistory?
    
    init(viewModel:VM){
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                if  !viewModel.items.isEmpty{
                    Section {
                        historySection
                            .padding()
                    } header: {
                        SelectDateView(listDate: viewModel.items, selectedDateProgress: $selectedDateInfo)
                            .background(Color.bgHeader)
                            .foregroundStyle(.white)
                            .shadow(radius: 2, y: 3)
                    }
                }else {
                    NoHistoryView()
                }
                
            }
        }
        .navigationTitle("History")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.bgHeader, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task{await update()}
        .animation(.smooth,value:viewModel.items)
        
        
    }
    
    func update () async {
        do{
            try await viewModel.loadContent()
        }catch {
            print("update historyList content error :\(error)")
        }
    }
    
    private var historySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            if let drink = selectedDateInfo {
                VStack {
                    SectionHistoryHeaderView(drinkDate: drink.drinkDate,
                                             drinkGoal: drink.drinkGoal,
                                             currentDrink: drink.currentDrink,
                                             isGoalAchived: drink.isGoalAchefed)
                }
                IntakeRecordListView(drinkRecords: drink.drinkRecored)
            }
        }
    }
}



