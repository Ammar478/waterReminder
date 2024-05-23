//
//  RingStatus.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import SwiftUI

struct RingStatus: View {
    var progress: CGFloat
    var total: Int
    var day:String

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .opacity(0.3)
                .foregroundColor(Color.pointer)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.pointer)
                .rotationEffect(Angle(degrees: -90))

            Text(day)

                .foregroundColor(.white)
        }
        .font(.callout)
    }
}

#Preview {
    RingStatus(progress: 0.3, total: 1,day:"8")
}
