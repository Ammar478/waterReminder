//
//  DashboardView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    var user:UserProfile
    @State private var cupSize: WaterIntake = WaterIntake(id: 0, amount: 100, drinkType: .water)
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 30) {
                    
                    UserWaterIntakeView(user: user, cupSize: $cupSize)
                    
                }
                
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
            .background(Rectangle()
                .fill( .linearGradient(colors: [cupSize.drinkType.color.opacity(0.3),.bgMain,.clear], startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            )
            
        }
        
    }
    
}
