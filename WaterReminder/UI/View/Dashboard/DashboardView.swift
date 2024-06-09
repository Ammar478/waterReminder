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
    @State private var cupSize: WaterIntake = WaterIntake(id: 0, amount: 150, drinkType: .water)
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 30) {
                    
                    UserWaterIntakeView(user: user, cupSize: $cupSize)
                    
                }
                
            }
            .navigationTitle("Today")
//            .navigationBarTitleDisplayMode(.inline)
            .customBackground()
            
        }
        
    }
    
}
