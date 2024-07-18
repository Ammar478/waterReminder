import SwiftUI
import SwiftData

struct HydrationSummary<VM:HistoryViewModel>: View {
    @State var viewModel:VM
    
    init(viewModel:VM){
        self._viewModel = .init(initialValue: viewModel)
    }
    
    
    var body: some View { 
        VStack(alignment: .leading, spacing: 20) {
            if !viewModel.items.isEmpty {
                HydrationListView(histories: viewModel.items.groupedByWeeks())
            }else {
                NoHistoryView()
            }
        }
        .padding(.top)
        .refreshable { await update() }
        .navigationTitle("Reports")
        .animation(.smooth,value:viewModel.items)
        .task{ await update()}
    }
    
    func update () async {
        do{
            try await viewModel.loadContent()
        }catch{
            print("load content hydrations :\(error)")
        }
    }
    
}




