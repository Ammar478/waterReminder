//
//  MockedDrinkHistory.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 05/11/1445 AH.
//

import Foundation

func generateMockDrinkHistories(for month: Int, year: Int) -> [DrinkHistory] {
    var drinkHistories = [DrinkHistory]()
    let calendar = Calendar.current
    let range = calendar.range(of: .day, in: .month, for: calendar.date(from: DateComponents(year: year, month: month))!)!

    for day in range {
        let date = calendar.date(from: DateComponents(year: year, month: month, day: day))!
        
        // Randomize drink data for variety
        let types: [DrinkTypes] = [.tea, .water, .coffee, .sparklingWater, .juices]
        let drinkRecord = (1...3).map { _ in
            IntakeRecords(
                drinkTime: date.addingTimeInterval(Double.random(in: 0...86400)),  // Random time in the day
                drinkinfo: WaterIntake(
                    id: Int.random(in: 1...100),
                    amount: Double.random(in: 200...500),
                    drinkType: types.randomElement()!
                )
            )
        }

        let totalIntake = drinkRecord.reduce(0) { $0 + $1.drinkinfo.amount }
        let drinkGoal = 2000.0  // Static daily drinking goal

        drinkHistories.append(
            DrinkHistory(
                drinkDate: date,
                drinkGoal: drinkGoal,
                currentDrink: totalIntake,
                isGoalAchefed: totalIntake >= drinkGoal,
                drinkedProgress: Float(totalIntake / drinkGoal),
                drinkRecored: drinkRecord
            )
        )
    }

    return drinkHistories
}
