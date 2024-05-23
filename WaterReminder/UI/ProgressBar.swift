//
//  ProgressBar.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import SwiftUI

struct ProgressBar: View {
    var amountDrinked:Double
    var dailyGoal:Double
    var progress:Float
    
    var isCompleted:Bool{
        progress >= 1
    }
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 20.0)
                .foregroundStyle(.pointer.opacity(0.3))
                
         
            
            Circle()
                .trim(from: 0.0,to:CGFloat(min(self.progress,1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10,lineCap: .round,lineJoin: .round))
                .foregroundStyle(isCompleted ? .success : .pointer)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 0.6),value:progress)

            
            VStack{
                Text(progress, format: .percent.precision(.fractionLength(0)))
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

#Preview {
    ProgressBar(amountDrinked: 3900, dailyGoal: 3000, progress: 0.3)
}
