//
//  DaySelect.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import SwiftUI

struct DaySelect: View {
    var progress :CGFloat = 0
    var total:Int = 1
    var dayName:String
    var isSelected:Bool
    var day:String
    
    var body: some View {
        VStack(spacing:10){
            Text(dayName)
                .font(.caption2)
                
            
            RingStatus(progress: progress, total: total,day: day)
            
            if isSelected{
                Circle()
                    .frame(width: 6)
                    .foregroundStyle(.pointer)
            }
        }

    }
}

#Preview {
    DaySelect(progress: 0.7, dayName: "M", isSelected: true,day: "6")
}
