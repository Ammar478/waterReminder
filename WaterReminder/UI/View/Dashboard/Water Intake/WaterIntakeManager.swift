//
//  WaterIntakeManager.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import SwiftUI
import SwiftData

protocol WaterIntakeManaging {
    func addIntakeWater(amount: WaterIntake ,modelContext:ModelContext)
    func changeCupSize(_ amount: WaterIntake, cupSize: Binding<WaterIntake>)
}


