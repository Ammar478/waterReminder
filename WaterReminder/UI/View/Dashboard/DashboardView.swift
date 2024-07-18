//
//  DashboardView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI
import SwiftData

struct DashboardView<VM:DashboardViewModel>: View {
    @State var viewModel: VM
    
    var user:UserProfile
    
    init(user:UserProfile,viewModel:VM){
        self.user = user
        self._viewModel = .init(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing: 30) {
                GaugeProgressView(progress: viewModel.progress, amountDrinked: viewModel.currentDrink
                                  ,dailyGoal: viewModel.dailyGoal
                )
                .frame(width: 180, height: 180)
                .padding()
                
                VStack(spacing: 10) {
                    AddWater(cupSize: viewModel.cupSize,
                             action: { try? await viewModel.addDailyDrink(amount: viewModel.cupSize) })
                    
                    WaterIntakeSelectionView(cupSize: $viewModel.cupSize,
                                             changeCupSize:{ viewModel.changeCupSize(amount: $0) })
                }
                
                HistoryOnDailyView(dailyDrinkHistory: viewModel.dailyDrinkHistory)
                    .padding(.horizontal,10)
                
            }
            .refreshable {await update()}
        }
        .navigationTitle("Today")
        .customBackground()
        .task {
            await update()
        }
        .animation(.smooth , value: viewModel.dailyDrinkHistory)
    }
    
    func update() async{
        do{
            try await viewModel.loadCountent()
        }catch{
            print("unable to load the dashboard:\(error)")
        }
    }
    
}


