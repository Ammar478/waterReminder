//
//  MainViewForUser.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import SwiftUI

struct MainView: View {
    var users:[UserProfile]
    
    var body: some View {
        if !users.isEmpty {
            ForEach(users) { user in
                TabView{
                    DashboardView(user: user)
                        .tabItem {
                            Label("Today", systemImage: "sun.horizon")
                        }
                    
                    HistoryView(user: user)
                        .tabItem {
                            Label("History",systemImage: "doc.badge.clock")
                        }
                    
                    HydrationSummary()
                        .tabItem {
                            Label("History",systemImage: "chart.line.uptrend.xyaxis")
                        }
                    
                    ReminderView()
                        .tabItem{
                            Label("Reminder",systemImage:"clock")
                        }
                }
                .tint(.orange)
                
            }

        }
                    
    }
}


