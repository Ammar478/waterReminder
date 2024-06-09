//
//  Prog.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/12/1445 AH.
//

import SwiftUI

struct GaugeProgressStyles: ProgressViewStyle {
    var amountDrinked:Double
    var dailyGoal:Double
    var trimAmount = 0.7
    var strokeColor = Color.pointer
    var strokeWidth = 25.0
    let formatter = NumberFormatter()

    var rotation: Angle {
        Angle(radians: .pi * (1 - trimAmount)) + Angle(radians: .pi / 2)
    }

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        formatter.numberStyle = .percent
        let percentage = formatter.string(from: fractionCompleted as NSNumber) ?? "0%"

        return ZStack {
            Circle()
                .rotation(rotation)
                .trim(from: 0, to: CGFloat(trimAmount))
                .stroke(strokeColor.opacity(0.5), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))

            Circle()
                .rotation(rotation)
                .trim(from: 0, to: CGFloat(trimAmount * fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))

            
              
                VStack{
                    Text(percentage)
                        .contentTransition(.numericText())
                        .font(.title)
                        .bold()
                        .foregroundStyle(.teal)
                        .monospacedDigit()
                        .shadow(color:.skyBlue,radius: 10)


                    VStack(alignment:.center){
                        HStack{
                            HStack{
                                Image(systemName: "drop.fill")
                                    .foregroundStyle(.pointer)
                                Text("Current : ")
                                    .foregroundStyle(.sText)
                            }
                            .bold()
                            .font(.caption)
                          
                               
                            
                            Text("\(amountDrinked,format: .number) mL")
                                .font(.caption2)
                                .foregroundStyle(.sText)
                                .opacity(1)
                                .animation(.bouncy, value: amountDrinked)
                                .monospacedDigit()
                        }
                        Divider()
                            .frame(width: 30)
                            
                        
                        HStack{
                            HStack{
                                Image(systemName: "trophy.fill")
                                    .foregroundStyle(.orange)
                                Text("Goal : ")
                                    .foregroundStyle(.sText)
                            }
                            .bold()
                            .font(.caption)
                          
                               

                            
                            Text("\(dailyGoal,specifier: "%.0f") mL")
                                .font(.caption2)
                                .foregroundStyle(.sText)
                                .opacity(1)
                                .monospacedDigit()
                        }
                    }
                }
        }
    }
}

struct GaugeProgressView: View {
     var progress:Float
    var amountDrinked:Double
    var dailyGoal:Double

    var body: some View {
        ProgressView("Label", value: progress, total: 1.0)
            .progressViewStyle(GaugeProgressStyles(amountDrinked: self.amountDrinked, dailyGoal: self.dailyGoal))
            .frame(width: 400)
    }
}

#Preview {
    GaugeProgressView(progress: 0.5 , amountDrinked: 2000, dailyGoal: 200)
}
