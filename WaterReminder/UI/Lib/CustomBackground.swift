//
//  CustomBackground.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/12/1445 AH.
//

import SwiftUI

struct CustomBackground:ViewModifier {
    func body(content:Content) -> some View {
        content
            .background(Rectangle()
                .fill( .linearGradient(colors: [.pointer.opacity(0.3),.bgMain,.clear], startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            )
    }
}

extension View {
    func customBackground()-> some View {
        modifier(CustomBackground())
    }
}
