//
//  IntakeRecordListView.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 30/06/2024.
//

import SwiftUI

struct IntakeRecordListView: View {
    var drinkRecords: [IntakeRecords]

    var body: some View {
        ForEach(drinkRecords, id: \.self) { item in
            IntakeRecoredElementView(intake: item)
                .deleteDisabled(false)
        }
    }
}
