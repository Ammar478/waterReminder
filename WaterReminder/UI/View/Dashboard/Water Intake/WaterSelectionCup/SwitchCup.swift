//
//  SwitchCup.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI

struct SwitchCup: View {
    @Environment(\.dismiss) var dismiss
    @Binding var cupSize: WaterIntake
    var action: (WaterIntake) -> Void

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    GridSection(title: nil, items: WaterIntakeSizes.waterAll, cupSize: $cupSize, action: action, dismiss: dismiss)
                    
                    GridSection(title: "Other Drink", items: WaterIntakeSizes.otherDrinks, cupSize: $cupSize, action: action, dismiss: dismiss)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Back", systemImage: "arrow.left")
                    }
                }
            }
            .navigationTitle("Switch Cup")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

