//
//  MainCoordinator.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 15/07/2024.
//

import Foundation
import SwiftUI

final class MainCoordinator:Coordinator {
    @Published  var localStorage:LocalStorage
    let onBoardingFLow:OnBordingCoordinator
    let authorizedFlow:AuthorizedCoordinator
    
    init(localStorage:LocalStorage, api:API){
        self.localStorage = localStorage
        self.onBoardingFLow = OnBordingCoordinator(storage: localStorage, api: api)
        self.authorizedFlow = AuthorizedCoordinator(localStorage: localStorage,api: api)
    }
    
    @ViewBuilder
    func rootView() -> some View {
        if let user = try? localStorage.fetchUsers(), !user.isEmpty {
            authorizedFlow.rootView()
        } else {
            onBoardingFLow.rootView()
        }
    }
}
