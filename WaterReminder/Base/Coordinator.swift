//
//  Coordinator.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 14/07/2024.
//

import SwiftUI

protocol Coordinator:ObservableObject{
    associatedtype RootView:View
    @MainActor @ViewBuilder func rootView() -> RootView
}
