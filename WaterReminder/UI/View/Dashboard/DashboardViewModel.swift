//
//  DashboardViewModal.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 15/07/2024.
//

import Foundation
import SwiftUI

protocol DashboardViewModel:ObservableObject{
    var cupSize:DrinkInformations { get set }
    var dailyDrinkHistory:[IntakeRecords] {get}
    var currentDrink:Double {get}
    var dailyGoal:Double {get}
    var progress:Float {get}
    var isAchivedGoal:Bool {get}
    func loadCountent() async throws
    func addDailyDrink(amount:DrinkInformations)async throws
    func changeCupSize(amount:DrinkInformations)
}

extension DashboardViewModel{
    var cupSize:DrinkInformations {.init(id: 0,amount: 150,drinkType: .water)}
    var isAchivedGoal:Bool {false}
}

final class _DashboardViewModel:DashboardViewModel{
    func changeCupSize(amount: DrinkInformations) {
        self.cupSize = amount
    }
    
    private let localStorage: LocalStorage
    private let api: API
    
    private var dailyDrink: DailyWaterDrink {
        willSet { Task { @MainActor in self.objectWillChange.send() } }
    }
    
    init(localStorage: LocalStorage, api: API, dailyDrink:DailyWaterDrink) {
        self.localStorage = localStorage
        self.api = api
        self.dailyDrink = dailyDrink
        self.cupSize = DrinkInformations(id: 0, amount: 150, drinkType: .water)
    }
    
    var cupSize: DrinkInformations
    
    var dailyGoal: Double {dailyDrink.dailyGoal}
    
    var currentDrink: Double {dailyDrink.currentDrink}
    
    var progress: Float {
        Float(dailyDrink.currentDrink / dailyDrink.dailyGoal)
    }
    
    var dailyDrinkHistory: [IntakeRecords]{dailyDrink.intakeRecords}
    
    
    var isAchivedGoal: Bool { dailyDrink.currentDrink >= dailyDrink.dailyGoal}
    
    
    func loadCountent() async throws {
        try await api.fetchDailyDrink(dailyDate: dailyDrink.dailyDate)
    }
    
    func addDailyDrink(amount: DrinkInformations) async throws {
        try await api.addDailyDrink(dailyDate: dailyDrink.dailyDate, drinkAmount: amount)
    }
    
}
