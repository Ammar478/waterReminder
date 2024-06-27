//
//  WaterReminderApp.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 22/10/1445 AH.
//

import SwiftUI
import SwiftData

@main
struct WaterReminderApp: App {
    @StateObject private var notificationManager = NotificationLocalManager()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserProfile.self,
          
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    

    var body: some Scene {
        WindowGroup {
            UserProfileView()
                .environmentObject(notificationManager)
        }
        .modelContainer(sharedModelContainer)
        
    }
}
