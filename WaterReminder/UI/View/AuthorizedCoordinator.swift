//
//  MainViewForUser.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import SwiftUI

final class AuthorizedCoordinator:Coordinator{
    let localStorage:LocalStorage
    let api : API
    
    let dashboard:DashboardCoordinator
    let history:HistoryCoordinator
    let hydrationSummary:HydrationSummaryCoordinator
    
    init(localStorage:LocalStorage,api:API){
        self.localStorage = localStorage
        self.api = api
        self.dashboard = DashboardCoordinator(localStorage: localStorage, api: api)
        self.history = HistoryCoordinator(localStorage: localStorage, api: api)
        self.hydrationSummary = HydrationSummaryCoordinator(localStorage: localStorage, api: api)
    }
    
    func rootView() -> some View {
        TabView{
            dashboard.rootView()
                .tabItem {
                    Label("Today", systemImage: "sun.horizon")
                }
            
            history.rootView()
                .tabItem {
                    Label("History",systemImage: "doc.badge.clock")
                }
            
            hydrationSummary.rootView()
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
