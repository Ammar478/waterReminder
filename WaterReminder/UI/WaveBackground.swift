//
//  Wave.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct WaveBackground: View {
    @Binding var animate: Bool
    
    var body: some View {
        ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.6))
                    .frame(width: 70, height: 70)
                    .scaleEffect(animate ? 1.2 : 1.0)
                    .opacity(animate ? 0.0 : 0.6)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: animate)
            }
            }
}


#Preview {
    WaveBackground(animate: .constant(false))
}
