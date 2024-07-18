//
//  HydrationCoordinator.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import SwiftUI

final class HydrationSummaryCoordinator:Coordinator {
    let localStorage:LocalStorage
    let api:API
    
    init(localStorage: LocalStorage, api: API) {
        self.localStorage = localStorage
        self.api = api
    }
    
    
    
    func rootView() -> some View {
        PathAwareNavigationStack{ pathBinding in
            let viewModel = _HistoryViewModel(localStorage: self.localStorage,
                                              api: self.api
            )
            HydrationSummary(viewModel: viewModel)
                .customBackground()
                .connecting(viewModel.query)
                .coordinate(localStorage: self.localStorage, api: self.api, drinkHistory: viewModel.items) {
                    guard !pathBinding.wrappedValue.isEmpty else { return }
                    pathBinding.wrappedValue.removeLast()
                }
            
            
        }
    }
}


fileprivate extension View{
    @MainActor @ViewBuilder
    func coordinate(localStorage:LocalStorage, api:API,drinkHistory:[DrinkHistory],dismiss:@MainActor @escaping() -> Void) -> some View {
        navigationDestination(for: ReportDestinations.self){destination in
            switch destination {
            case .intake:
                DrinkIntakeDetailsCoordinator(localStorage: localStorage, api: api, drinkHistories: drinkHistory, dismiss: dismiss).rootView()
            case .goal:
                DrinkTyprDetailsCoordinator(localStorage: localStorage, api: api, drinkHistories: drinkHistory, dismiss: dismiss).rootView()
            }
        }
        .connecting(localStorage)
    }
}
