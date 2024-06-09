//
//  WaterDropIcon.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI

struct NumberAnimatableValue: View ,Animatable{
    var value:Double
    
    var formatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var animatableData:Double{
        get{value}
        set {
            value = newValue
        }
    }
    var body: some View {
        Text(formatter.string(for: value) ?? "")
    }
}

#Preview {
    NumberAnimatableValue(value: 390)
}
