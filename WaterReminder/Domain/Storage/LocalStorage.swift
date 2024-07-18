//
//  LocalStorage.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 14/07/2024.
//

import Foundation
import SwiftData
import SwiftUI
import CoreML


class LocalStorage: ObservableObject {
    
    private(set) var modelContainer:ModelContainer = {
        let schema = Schema([
            UserProfile.self,
        ])
        
        let modelConfiguration = if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            ModelConfiguration(schema:schema , isStoredInMemoryOnly: true)
        } else {
            ModelConfiguration(schema:schema,isStoredInMemoryOnly: false)
        }
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not creat ModelContainer: \(error)")
        }
    }()
    
    @MainActor
    var mainContext: ModelContext {modelContainer.mainContext}
    func backgroundContext() -> ModelContext { ModelContext(modelContainer)}
    
    func fetchUsers () throws -> [UserProfile]{
        let context = backgroundContext()
        return  try context.fetch(.init())
    }
    
    @MainActor
    func fetchUser(userId:UUID) throws -> UserProfile {
        try fetchUserBy(userId: userId, context: modelContainer.mainContext)
    }
    
    func fetchFirstUser() throws -> UserProfile? {
        let context = backgroundContext()
        
        return try context.fetch(FetchDescriptor<UserProfile>(sortBy: [SortDescriptor(\.userId)])).first ?? nil
        
    }
    
    @MainActor
    func createUser(user:UserProfile) throws -> UserProfile {
        try createUser(user: user,context: modelContainer.mainContext)
    }
    
    private func createUser(user:UserProfile,context:ModelContext) throws -> UserProfile{

        let drinkGoal = try generateDailyGoal(user: user,
                                              amount: DailyWaterDrink.defaultDrinkAmount,
                                              previusGoal: DailyWaterDrink.defaultPreviuseGoal,
                                              isGoalMet: .notAchieved)
        
        let userInfo = UserProfile(
            age: user.age,
            height: user.height,
            weight: user.weight,
            gender: user.gender,
            activityLevel: user.activityLevel,
            dailyDrink: DailyWaterDrink(dailyDate: Date(),
                                        dailyGoal: drinkGoal,
                                        currentDrink: DailyWaterDrink.defaultCurrentDrink
                                       )
        )
        
        context.insert(userInfo)
        try context.save()
        return userInfo
    }
    
    func updateOrfetchUser(userId:UUID , update:(UserProfile) throws -> Void) throws -> UserProfile{
        let context = backgroundContext()
        let user = try fetchUserBy(userId: userId, context: context)
        context.autosaveEnabled = false
        try update(user)
        try context.save()
        return user
    }
    
    private func fetchUserBy(userId:UUID , context:ModelContext) throws -> UserProfile {
        try  context.fetch(FetchDescriptor<UserProfile>(predicate:#Predicate{
            $0.userId == userId
        })).first!
    }
    
    @MainActor
    func fetchDailyDrink(dailyDate:Date) throws -> DailyWaterDrink{
        try fetchDailyDrink(dailyDate: dailyDate,context: modelContainer.mainContext)
    }
    
    func addDailyDrink(dailyDate:Date,drinkAmount:DrinkInformations) throws -> DailyWaterDrink {
        try updateDailyDrink(dailyDate: dailyDate){daily in
            daily.currentDrink += drinkAmount.amount
            daily.intakeRecords.append(IntakeRecords(drinkTime: Date(), drinkinfo: drinkAmount))
            
        }
    }
    
    func updateDailyDrink(dailyDate:Date,update:(DailyWaterDrink) throws -> Void) throws -> DailyWaterDrink{
        let context = backgroundContext()
        let dailyDrinlInfo = try fetchDailyDrink(dailyDate: dailyDate,context: context)
        context.autosaveEnabled = false
        try update(dailyDrinlInfo)
        try context.save()
        return dailyDrinlInfo
    }
    
    private func fetchDailyDrink(dailyDate:Date,context:ModelContext) throws -> DailyWaterDrink{
        return try context.fetch(FetchDescriptor<DailyWaterDrink>(predicate:#Predicate{
            $0.dailyDate == dailyDate
        })).first!
    }
    
    ///todo : may we don't need them
    @MainActor
    func fetchDrinkHistory(historyDate :Date) throws -> DrinkHistory {
        try fetchDrinkHistoryRecord(date: historyDate, context: modelContainer.mainContext)
    }
    ///todo: may we don't need them
    func fetchDrinkHistories() throws -> [DrinkHistory]{
        let context = backgroundContext()
        return try context.fetch(FetchDescriptor<DrinkHistory>(sortBy: [SortDescriptor(\.drinkDate,order: .reverse)]))
    }
    ///todo : may we don't need them
    private func fetchDrinkHistoryRecord(date:Date , context:ModelContext) throws -> DrinkHistory{
        return try context.fetch(FetchDescriptor<DrinkHistory>(predicate: #Predicate{
            $0.drinkDate == date
        })).first!
    }
    
    
    private func generateDailyGoal(user:UserProfile,amount:Int64 , previusGoal:Int64 , isGoalMet:MetDailyGoal) throws -> Double {
        
        do{
            let configML = MLModelConfiguration()
            let model = try GeneraterHydrationWaterGoals(configuration: configML)
            let MLOutput = try model.prediction(age: Int64(user.age),
                                                weight: Int64(user.weight),
                                                sex: user.gender.rawValue, activity_level: user.activityLevel.rawValue, initial_goal: previusGoal , intake: amount, is_goal_met: isGoalMet.rawValue
            )
            
            
            return  MLOutput.next_day_goal
        }catch{
            print("error prediction model output: \(error)")
            return DailyWaterDrink.defalutGoal
        }
    }
    
}

extension View {
    @ViewBuilder
    func connecting(_ storage: LocalStorage) -> some View {
        self.modelContainer(storage.modelContainer)
    }
}

extension Scene {
    @SceneBuilder
    func connecting(_ storage: LocalStorage) -> some Scene {
        self.modelContainer(storage.modelContainer)
    }
}
