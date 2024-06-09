//
//  StatCard.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 09/11/1445 AH.
//

import SwiftUI

struct StatCard: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .center) {
            Text(label)
                .font(.callout)
                .foregroundColor(.secondary)
            Spacer()
            
            Text(value)
                .font(.caption)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
    }
}
