//
//  HistoryCoordinator.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import SwiftUI

final class HistoryCoordinator:Coordinator {
    let localStorage:LocalStorage
    let api:API
    
    init(localStorage: LocalStorage, api: API) {
        self.localStorage = localStorage
        self.api = api
    }
    
    func rootView() -> some View {
        NavigationStack{
            let viewModel = _HistoryViewModel(localStorage: self.localStorage, api: self.api)
            HistoryView(viewModel: viewModel)
                .connecting(viewModel.query)
                .customBackground()
        }
    }
}
