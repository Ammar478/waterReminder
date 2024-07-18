//
//  DashboardCoordinator.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 15/07/2024.
//

import Foundation
import SwiftUI

final class DashboardCoordinator:Coordinator {
    let localStorage:LocalStorage
    let api:API
    
    init(localStorage: LocalStorage, api: API) {
        self.localStorage = localStorage
        self.api = api
    }
    
    func rootView() -> some View {
        NavigationStack{
            if let user = try? localStorage.fetchFirstUser()  {
                
                let viewModel = _DashboardViewModel(localStorage: self.localStorage,
                                                    api: self.api,
                                                    dailyDrink: user.dailyDrink!
                )
                DashboardView(user: user,
                              viewModel: viewModel)
                .connecting(localStorage)
            }
        }
    }
}
