//
//  ChangeCupButtonContent.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 27/06/2024.
//

import SwiftUI

struct ChangeCupButtonContent: View {
    var body: some View {
        VStack {
            Image(systemName: "waterbottle.fill")
                .font(.title)
                .foregroundStyle(.pointer)
                .overlay(
                    Circle()
                        .stroke(Color.pointer.opacity(0.5), lineWidth: 0.6)
                        .frame(width: 100, height: 60)
                )
            
            Image(systemName: "arrow.triangle.2.circlepath.circle")
                .background()
                .foregroundStyle(Color.pointer.opacity(0.7))
            
            Text("Change")
                .foregroundStyle(.sText)
                .font(.caption2)
        }
    }
}
#Preview {
    ChangeCupButtonContent()
}
