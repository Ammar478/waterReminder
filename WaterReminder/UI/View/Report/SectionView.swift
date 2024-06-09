//
//  SectionView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 09/11/1445 AH.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .padding(.bottom, 5)
                .foregroundStyle(.secondary)
            VStack( spacing: 15) {
                content
            }
           
        }
        .padding(.bottom)
    }
}
