//
//  MockAPI.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 15/07/2024.
//

import Foundation

struct MockAPI:API {
    let localStorage:LocalStorage
    
    init(localStorage:LocalStorage) {
        self.localStorage = localStorage
    }
    
    func fetchUsers() async throws -> [UserProfile] {
        try localStorage.fetchUsers()
    }
    
    func fetchFirstUser() async throws -> UserProfile? {
        try localStorage.fetchFirstUser()
    }
    
    func fetchUser(userId: UUID) async throws -> UserProfile {
        try await localStorage.fetchUser(userId: userId)
    }
    
    func createUser(user: UserProfile) async throws -> UserProfile {
        try  await localStorage.createUser(user: user)
    }
    
    func fetchDailyDrink(dailyDate: Date) async throws -> DailyWaterDrink {
        try await localStorage.fetchDailyDrink(dailyDate: dailyDate)
    }
    
    func addDailyDrink(dailyDate: Date, drinkAmount: DrinkInformations) async throws -> DailyWaterDrink {
        try  localStorage.addDailyDrink(dailyDate: dailyDate, drinkAmount: drinkAmount)
    }

    func fetchDrinkHistories() async throws -> [DrinkHistory] {
        try localStorage.fetchDrinkHistories()
    }
}
