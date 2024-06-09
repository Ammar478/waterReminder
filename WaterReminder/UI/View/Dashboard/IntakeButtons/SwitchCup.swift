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
    var action:(WaterIntake)->Void
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    

    var body: some View {
        NavigationStack {
            ScrollView (.vertical,showsIndicators: false){
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(WaterIntakeSizes.waterAll) { intake in
                        DrinkCupButton(intake: intake, selectedAmount: $cupSize) {
                            action(intake)
                            dismiss()
                        }
                    }
                    
                }
               
                HStack(alignment: .center){
                    Text("Other Drink ")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    VStack{
                        Divider()
                    }
                }
                .frame(maxWidth: .infinity)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(WaterIntakeSizes.otherDrinks) { intake in
                        DrinkCupButton(intake: intake, selectedAmount: $cupSize) {
                            action(intake)
                            dismiss()
                        }
                    }
                    
                }
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
            .padding()
        }
       

    }
}




struct WaterIntake: Identifiable,Codable,Hashable {
    var id: Int
    var amount: Double
    var drinkType:DrinkTypes
    
    var hydrationLevel: Double {
        switch drinkType {
        case .water:
            return 1.0
        case .tea:
            return 0.9
        case .coffee:
            return 0.95
        case .sparklingWater:
            return 1.0
        case .juices:
            return 0.8
        }
    }

    var sugarContent: Double {
        switch drinkType {
        case .water, .tea, .coffee, .sparklingWater:
            return 0.0
        case .juices:
            return 10.0 // grams per 100ml
        }
    }
    
}
