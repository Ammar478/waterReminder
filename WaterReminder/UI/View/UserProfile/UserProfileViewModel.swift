//
//  UserProfileViewModel.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import Foundation
import SwiftUI

@Observable
final class UserProfileViewModel {

    func handleNewDay(users: [UserProfile]) {
        let currentDate = Date.now
        let lastRecordedDate = users.first?.dailyWater?.dailyDate
        
        if let record = lastRecordedDate, isDifferentDay(currentDate, from: record) {
            recordNewDay(users: users, nextDate: currentDate)
        }
    }
    
    private func recordNewDay(users: [UserProfile], nextDate: Date) {
        for user in users {
            user.addNewDailyHistoryRecord(nextDate: nextDate)
        }
    }
    
    private func isDifferentDay(_ date1: Date, from date2: Date) -> Bool {
        let calendar = Calendar.current
        return !calendar.isDate(date1, inSameDayAs: date2)
    }
}
