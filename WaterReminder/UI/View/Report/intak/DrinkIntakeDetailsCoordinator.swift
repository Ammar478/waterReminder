//
//  DrinkIntakeDetailsCoordinator.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import SwiftUI

final class DrinkIntakeDetailsCoordinator:Coordinator {
    
    let localStorage:LocalStorage
    let api:API
    let drinkHistories:[DrinkHistory]
    let dismiss: @MainActor()-> Void
   
    
    init(localStorage: LocalStorage, api: API, drinkHistories: [DrinkHistory], dismiss:@MainActor @escaping () -> Void) {
        self.localStorage = localStorage
        self.api = api
        self.drinkHistories = drinkHistories
        self.dismiss = dismiss
    }
    
    func rootView() -> some View {
        WaterIntakeDetailsSummary(viewModel: _DrinkIntakeDetailsModel(api: self.api, localStorage: self.localStorage, dismissAction: dismiss, drinkHistories: self.drinkHistories))
            .connecting(localStorage)
    }
    
}
