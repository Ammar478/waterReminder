//
//  SectionHistoryHeaderView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/12/1445 AH.
//

import SwiftUI

struct SectionHistoryHeaderView: View {
    let drinkDate:Date
    let drinkGoal:Double
    let currentDrink:Double
    let isGoalAchived:Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(drinkDate.YearFormatter)
                .foregroundStyle(.secondary)
                .font(.caption)
            
            VStack {
                Divider()
            }
            
            HStack(spacing: 5) {
                Image(systemName: "trophy.fill")
                    .foregroundStyle(.orange)
                Text("\(drinkGoal, specifier: "%.0f")")
            }
            .font(.caption)
            .bold(!isGoalAchived)
            
            HStack(spacing: 5) {
                Image(systemName: "drop.fill")
                    .foregroundStyle(.pointer)
                
                Text("\(currentDrink, specifier: "%.0f")")
            }
            .font(.caption)
            .bold(!isGoalAchived)
            
        }
    }
}

