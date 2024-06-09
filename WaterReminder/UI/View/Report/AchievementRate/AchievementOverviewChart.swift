//
//  AchievementOverviewChart.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 02/11/1445 AH.
//

import Charts
import SwiftUI

struct AchievementOverviewChart: View {
    var overviewData:[DrinkHistory]
    let symbolSize: CGFloat = 100
    let lineWidth: CGFloat = 3
    
    var body: some View {
        Chart {
            ForEach(overviewData, id: \.drinkDate){element in
                LineMark(x: .value("Date", element.drinkDate), y: .value("Goal", element.drinkGoal))
                LineMark(
                    x: .value("Date", element.drinkDate), y: .value("Intake", element.currentDrink))
            }
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: lineWidth))
            .symbolSize(symbolSize)
        }
        
        .chartForegroundStyleScale([
            "San Francisco": .purple,
            "Cupertino": .green
        ])
        .chartSymbolScale([
            "San Francisco": Circle().strokeBorder(lineWidth: lineWidth),
            "Cupertino": Square().strokeBorder(lineWidth: lineWidth)
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.narrow), centered: true)
            }
        }
        .chartYAxis(.hidden)
        .chartYScale(range: .plotDimension(endPadding: 8))
        .chartLegend(.hidden)
    }
}

#Preview {
    AchievementOverviewChart(overviewData: [])
}

/// A square symbol for charts.
struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat

    init(inset: CGFloat = 0) {
        self.inset = inset
    }

    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }

    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }

    var perceptualUnitRect: CGRect {
        // The width of the unit rectangle (square). Adjust this to
        // size the diamond symbol so it perceptually matches with
        // the circle.
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}
