//
//  EnableNotificationView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 11/11/1445 AH.
//

import SwiftUI

struct EnableNotificationsView: View {
    @ObservedObject private var notificationManager = NotificationLocalManager()

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Stay Hydrated!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Enable Notifications for Water Reminders")
                .font(.headline)
                .foregroundColor(.gray)
            
            Image(systemName: "bell.badge.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.orange)
            
            Text("Enable notifications to get reminders to drink water and stay hydrated throughout the day. We'll help you meet your daily hydration goals!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            Spacer()
            
            Button(action: {notificationManager.openSetting()}) {
                Text("Enable Notifications")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pointer)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            
            
            Spacer()
        }
        .padding()
    }
}

struct EnableNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        EnableNotificationsView()
    }
}
