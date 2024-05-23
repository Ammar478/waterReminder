//
//  CardContent.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 10/11/1445 AH.
//

import SwiftUI

struct CardContent: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .center) {
            Text(label)
                .font(.callout)
                .foregroundColor(.p1)
            Spacer()
            
            Text(value)
                .font(.caption)
                .foregroundColor(color)
                .bold()
        }
        .frame(maxWidth: .infinity)
    }
}
