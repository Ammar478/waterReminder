//
//  API.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 15/07/2024.
//

import Foundation

protocol API {
    @discardableResult
    func fetchUsers() async throws -> [UserProfile]
    @discardableResult
    func fetchUser(userId:UUID) async throws -> UserProfile
    @discardableResult
    func fetchFirstUser() async throws -> UserProfile?
    @discardableResult
    func createUser(user:UserProfile) async throws -> UserProfile
    @discardableResult
    func fetchDailyDrink(dailyDate:Date) async throws -> DailyWaterDrink
    @discardableResult
    func addDailyDrink(dailyDate:Date, drinkAmount:DrinkInformations) async throws -> DailyWaterDrink
    @discardableResult
    func fetchDrinkHistories() async throws -> [DrinkHistory]
}

extension API {
    static func defaultDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-d"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}
