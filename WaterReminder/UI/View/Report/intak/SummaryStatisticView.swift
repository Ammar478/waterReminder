//
//  SummaryStatisticView.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 30/06/2024.
//

import SwiftUI

struct SummaryStatisticView: View {
    let title: String
    let value: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(isSelected ? Color.orange : Color(.systemGray5)))
    }
}
