//
//  AddWater.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI

struct ChangeCupButton: View {
    @Binding var cupSize: WaterIntake
    @State private var isSheetPresented: Bool = false
    var action: (WaterIntake) -> Void

    var body: some View {
        Button(action: {
            self.isSheetPresented.toggle()
        }) {
            ChangeCupButtonContent()
        }
        .sheet(isPresented: $isSheetPresented) {
            SwitchCup(cupSize: $cupSize, action: action)
        }
    }
}
