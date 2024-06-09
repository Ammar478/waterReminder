//
//  RootView\.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI
import SwiftData

struct RootView: View {
    
    @Query private var users:[UserProfile]
    
    var body: some View {
        VStack{
            switch users.isEmpty{
            case true:
                OnBordingView()
            case false:
                MainView(users: users)
                    .onAppear {
                        handleNewDay()
                    }
            }
        }
        
    }
    
    private func handleNewDay() {
        let currentDate = Date.now
        let lastRecordedDate = users.first?.dailyWater?.dailyDate ?? nil
        
        if let record = lastRecordedDate{
            if isDifferentDay(currentDate, from: record) {
                recordNewDay(currentDate)
            }
        }else{
            return
        }
    }
    
    private func recordNewDay(_ nextDate:Date) {
        for user in users {
            user.addNewDailyHistoryRecord(nextDate:nextDate)
        }
        
    }
    
}

#Preview {
    RootView()
        .modelContainer(for: [UserProfile.self], inMemory: true)
}

