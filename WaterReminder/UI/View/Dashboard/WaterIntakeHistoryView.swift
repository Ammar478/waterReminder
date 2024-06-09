//
//  WaterIntakeHistoryView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct WaterIntakeHistoryView: View {
    var intakeRecords: [IntakeRecords]

    var body: some View {
        GroupBox {
            if intakeRecords.isEmpty {
                ContentUnavailableView( "No history available", systemImage: "list.clipboard")
                    
            } else {
                List(intakeRecords.prefix(5)) { intake in
                    HStack {
                        Text("\(intake.amountOfDrink.formatted(.number)) liters")
                        Spacer()
                        Text("\(intake.drinkTime.formatted(date: .numeric, time: .shortened))")
                    }
                    .padding()
                }
            }
        } label: {
            Label("History", systemImage: "clock.arrow.circlepath")
                .font(.title3)
                .foregroundStyle(.primary)
        }
        .padding()
    }
}

#Preview {
    WaterIntakeHistoryView(intakeRecords: [])
}
