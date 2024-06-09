//
//  AddWater.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI

struct ChangeCupButton: View {
    @Binding var cupSize:WaterIntake
    @State private var updateTheCup:Bool = false
    var action:(WaterIntake)->Void
    
    var body: some View {
        Button{
            self.updateTheCup.toggle()
        }label: {
            VStack{
                Image(systemName: "waterbottle.fill")
                    .font(.title)
                    .foregroundStyle(.pointer)
                    .overlay(
                        Circle()
                            .stroke(.pointer.opacity(0.5),lineWidth: 0.6)
                            .frame(width: 100,height: 60)
                    )
                
                Image(systemName: "arrow.triangle.2.circlepath.circle")
                    .background()
                    .foregroundStyle(.pointer.opacity(0.7))
                
                
                Text("change")
                    .foregroundStyle(.sText )
                    .font(.caption2)

            }
          
            
        }
        .sheet(isPresented: $updateTheCup){
            SwitchCup(cupSize: $cupSize,action: action)
        }
    }
}
