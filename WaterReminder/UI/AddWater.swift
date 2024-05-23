//
//  AddWater.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct AddWater: View {
    var cupSize: WaterIntake
    var action:()->Void
    
    
    @State private var isAnimating = false
    
    var body: some View {
        
        Button(action: {
            action()
            withAnimation(.easeInOut(duration: 0.3)) {
                isAnimating.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isAnimating.toggle()
                }
            }
        }) {
            
            VStack{
                ZStack{
                    Image(systemName: cupSize.drinkType.systemImage)
                        .font(.title)
                        .foregroundColor(.white)
                        .scaleEffect(!isAnimating ? 1 : 1.5)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                }
                .frame(width: 70, height: 70)
                .background(Circle().fill(cupSize.drinkType.color))
                .shadow(color: cupSize.drinkType.color.opacity(1), radius: isAnimating ? 12 : 10)
                
                Text("\(Int(cupSize.amount)) mL")
                    .foregroundColor(.p1)
                    .font(.callout)
                    .bold()
            }
            
            
        }
        
    }  
    
}



