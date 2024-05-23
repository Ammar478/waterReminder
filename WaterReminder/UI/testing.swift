//
//  testing.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 25/10/1445 AH.
//

import SwiftUI

struct testing: View {
    var body: some View {
        AnimatedCupView()
    }
}

#Preview {
    testing()
}

struct AnimatedCupView: View {
    @State private var arrowOffset: CGFloat = 0
       @State private var arrowOpacity: Double = 1
       
       var body: some View {
           GeometryReader { geometry in
               Path { path in
                   let width = geometry.size.width
                   let height = geometry.size.height
                   let cupWidth = width * 0.2
                   let cupHeight = height * 0.2

                   let startX = (width - cupWidth) / 3
                   let startY = (height - cupHeight) / 2

                   // Draw the cup
                   path.move(to: CGPoint(x: startX, y: startY + cupHeight))
                   path.addLine(to: CGPoint(x: startX, y: startY))
                   path.addLine(to: CGPoint(x: startX + cupWidth, y: startY))
                   path.addLine(to: CGPoint(x: startX + cupWidth, y: startY + cupHeight))
                   
                   // Draw the handle
                   path.addArc(center: CGPoint(x: startX + cupWidth, y: startY + cupHeight / 2),
                               radius: cupWidth / 4,
                               startAngle: .degrees(0),
                               endAngle: .degrees(180),
                               clockwise: false)
               }
               .stroke(Color.blue, lineWidth: 4)
           }
       }
   }
