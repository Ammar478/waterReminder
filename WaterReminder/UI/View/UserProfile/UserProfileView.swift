//
//  UserProfileView.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import SwiftUI
import SwiftData

struct UserProfileView: View {
    
    @Query private var users: [UserProfile]
    @State private var viewModel = UserProfileViewModel()
    
    var body: some View {
        VStack {
            switch users.isEmpty {
            case true:
                OnBordingView()
            case false:
                MainView(users: users)
                    .onAppear {
                        viewModel.handleNewDay(users: users)
                    }
            }
        }
    }
}

#Preview {
    UserProfileView()
}
