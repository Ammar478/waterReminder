//
//  WaterBottleButton.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 25/10/1445 AH.
//

import SwiftUI


struct DrinkCupButton: View {
    var intake: WaterIntake
    @Binding var selectedAmount: WaterIntake
    let action: () -> Void

    var body: some View {
        Button(action: buttonAction) {
            VStack(spacing: 15) {
                drinkImage
                drinkAmountText
            }
        }
        .frame(height: 100)
    }
    
    private var drinkImage: some View {
        Image(systemName: intake.drinkType.systemImage)
            .font(.title)
            .foregroundStyle(isSelected ? intake.drinkType.color : intake.drinkType.color.opacity(0.5))
            .overlay(
                Circle()
                    .stroke(isSelected ? intake.drinkType.color : intake.drinkType.color.opacity(0.5), lineWidth: isSelected ? 2 : 0.5)
                    .frame(width: 100, height: 60)
            )
    }
    
    private var drinkAmountText: some View {
        Text("\(intake.amount.formatted(.number)) mL")
            .foregroundStyle(isSelected ? .sText : .sText.opacity(0.5))
            .font(.caption2)
            .bold(isSelected)
    }

    private var isSelected: Bool {
        selectedAmount.id == intake.id
    }

    private func buttonAction() {
        withAnimation(.easeIn(duration: 0.3)) {
            selectedAmount = intake
            action()
        }
    }
}

