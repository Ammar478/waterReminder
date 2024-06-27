//
//  GridSection.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import SwiftUI

struct GridSection: View {
    var title: String?
    var items: [WaterIntake]
    @Binding var cupSize: WaterIntake
    var action: (WaterIntake) -> Void
    var dismiss: DismissAction

    var body: some View {
        if let title = title {
            HStack(alignment: .center) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                VStack {
                    Divider()
                }
            }
            .frame(maxWidth: .infinity)
        }

        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 20) {
            ForEach(items) { intake in
                DrinkCupButton(intake: intake, selectedAmount: $cupSize) {
                    action(intake)
                    dismiss()
                }
            }
        }
    }
}

