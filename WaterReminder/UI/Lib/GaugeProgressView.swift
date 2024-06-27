//
//  Prog.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/12/1445 AH.
//

import SwiftUI

struct GaugeProgressStyles: ProgressViewStyle {
    var amountDrinked: Double
    var dailyGoal: Double
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
            GaugeBackground(trimAmount: trimAmount, strokeColor: strokeColor, strokeWidth: strokeWidth, rotation: rotation)
            GaugeForeground(trimAmount: trimAmount, fractionCompleted: fractionCompleted, strokeColor: strokeColor, strokeWidth: strokeWidth, rotation: rotation)
            GaugeCenterContent(percentage: percentage, amountDrinked: amountDrinked, dailyGoal: dailyGoal)
        }
    }
}

struct GaugeBackground: View {
    var trimAmount: Double
    var strokeColor: Color
    var strokeWidth: Double
    var rotation: Angle

    var body: some View {
        Circle()
            .rotation(rotation)
            .trim(from: 0, to: CGFloat(trimAmount))
            .stroke(strokeColor.opacity(0.5), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
    }
}

struct GaugeForeground: View {
    var trimAmount: Double
    var fractionCompleted: Double
    var strokeColor: Color
    var strokeWidth: Double
    var rotation: Angle

    var body: some View {
        Circle()
            .rotation(rotation)
            .trim(from: 0, to: CGFloat(trimAmount * fractionCompleted))
            .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
    }
}

struct GaugeCenterContent: View {
    var percentage: String
    var amountDrinked: Double
    var dailyGoal: Double

    var body: some View {
        VStack {
            Text(percentage)
                .contentTransition(.numericText())
                .font(.title)
                .bold()
                .foregroundStyle(.teal)
                .monospacedDigit()
                .shadow(color: .skyBlue, radius: 10)
            GaugeInfo(amountDrinked: amountDrinked, dailyGoal: dailyGoal)
        }
    }
}

struct GaugeInfo: View {
    var amountDrinked: Double
    var dailyGoal: Double

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                GaugeInfoRow(image: "drop.fill", label: "Current:", value: "\(amountDrinked.formatted(.number)) mL", color: .pointer)
            }
            Divider()
                .frame(width: 30)
            HStack {
                GaugeInfoRow(image: "trophy.fill", label: "Goal:", value: "\(dailyGoal.formatted(.number.precision(.fractionLength(0)))) mL", color: .orange)
            }
        }
    }
}

struct GaugeInfoRow: View {
    var image: String
    var label: String
    var value: String
    var color: Color

    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundStyle(color)
            Text(label)
                .foregroundStyle(.sText)
            Text(value)
                .font(.caption2)
                .foregroundStyle(.sText)
                .opacity(1)
                .monospacedDigit()
        }
        .bold()
        .font(.caption)
    }
}

struct GaugeProgressView: View {
    var progress: Float
    var amountDrinked: Double
    var dailyGoal: Double

    var body: some View {
        ProgressView("Label", value: progress, total: 1.0)
            .progressViewStyle(GaugeProgressStyles(amountDrinked: amountDrinked, dailyGoal: dailyGoal))
            .frame(width: 400)
    }
}

#Preview {
    GaugeProgressView(progress: 0.5, amountDrinked: 2000, dailyGoal: 2000)
}
