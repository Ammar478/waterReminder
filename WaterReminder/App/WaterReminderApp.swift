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
    @StateObject var coordinator: MainCoordinator
    @StateObject var localStorage: LocalStorage
    @State var api: API

    init() {
        let localStorage = LocalStorage()
        let api = MockAPI(localStorage: localStorage)
        
        _api = .init(initialValue: api)
        _coordinator = .init(wrappedValue: MainCoordinator(
            localStorage: localStorage,
            api: api
        ))
        _localStorage = .init(wrappedValue: localStorage)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.rootView()
        }
        .windowResizability(.contentSize)       
    }
}
