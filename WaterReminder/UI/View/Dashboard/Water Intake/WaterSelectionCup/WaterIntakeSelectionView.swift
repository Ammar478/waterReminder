//
//  WaterIntakeSelectionView.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import SwiftUI

struct WaterIntakeSelectionView: View {
    @Binding var cupSize: WaterIntake
     var changeCupSize: (WaterIntake) -> Void
     
     var body: some View {
         HStack(alignment: .center, spacing: 30) {
             ForEach(WaterIntakeSizes.waterAll.prefix(3)) { intake in
                 DrinkCupButton(intake: intake, selectedAmount: $cupSize, action: { changeCupSize(intake) })
             }
             ChangeCupButton(cupSize: $cupSize, action: changeCupSize)
         }
     }
 }
