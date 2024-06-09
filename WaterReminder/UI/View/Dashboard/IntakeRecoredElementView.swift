//
//  IntakeRecoredElementView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct IntakeRecoredElementView: View {
    
    var intake:IntakeRecords
    var body: some View {
        GroupBox{
            HStack {
                VStack(alignment: .center) {
                    HStack(spacing: 6) {
                        Image(systemName: intake.drinkinfo.drinkType.systemImage)
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                        
                        Text("\(intake.drinkinfo.amount, specifier: "%.0f") mL")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding(10)
                    .padding([.leading, .trailing], 15)
                    .frame(width: 140)
                }
                .background(intake.drinkinfo.drinkType.color)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                
                Text(intake.drinkinfo.drinkType.title)
                    .font(.headline)
                    .foregroundColor(.p1)
                    .bold()
                
                Spacer()
                   
                Text(intake.drinkTime.formatted(date: .omitted, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.sText)
            }
            .padding(-10)
        }
    }
    
}
