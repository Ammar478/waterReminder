//
//  NoHistoryWater.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 11/11/1445 AH.
//

import SwiftUI

struct NoHistoryView: View {
    @State private var animate = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            HStack(spacing: 14) {
                Image(systemName: "drop.circle.fill")
                    .resizable()
                    .blur(radius: 0.7)
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.pointer.opacity(0.3))
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
                
                Image(systemName: "drop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.pointer)
                    .scaleEffect(animate ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
                
                Image(systemName: "drop.circle.fill")
                    .resizable()
                    .blur(radius: 0.7)
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.pointer.opacity(0.3))
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
            }
            .padding(.bottom, 20)
            .onAppear {
                self.animate = true
            }
            
            VStack(spacing: 15) {
                Text("No Drink History Available")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("It looks like you haven't logged any drinks yet. Start tracking your water intake to stay hydrated and healthy.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .padding(.horizontal)
    }
}
