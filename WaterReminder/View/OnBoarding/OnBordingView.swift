//
//  OnBordingView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/11/1445 AH.
//

import SwiftUI

struct OnBordingView: View {
    @State private var activeIntro:PageIntro = pagesIntro[0]
    @State private var keyboardHeight:CGFloat = 0
    
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            IntroView(inro: $activeIntro, size: size){
                PersonalInfoView()
            }
        }
        .padding()
        .background(Rectangle()
            .fill( .linearGradient(colors: [.pointer.opacity(0.3),.bgMain,.clear], startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
        )
    }
}

