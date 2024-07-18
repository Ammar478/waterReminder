//
//  WaterIntakeManager.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import SwiftUI
import SwiftData

protocol WaterIntakeManaging {
    func addIntakeWater(amount: DrinkInformations ,modelContext:ModelContext)
    func changeCupSize(_ amount: DrinkInformations, cupSize: Binding<DrinkInformations>)
}


