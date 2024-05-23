//
//  DailyDetailsCharts.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 06/11/1445 AH.
//

import Charts
import SwiftUI

struct HydrationWeeklyChart: View {
   @Binding var showCase: ReportCases
    @Binding var scrollPosition:Date
    var formattedDate: [DrinkHistory]
    @State var buttonStyle = SelectableButtonStyle()
    
    
    var maxIntakeDay: DrinkHistory? {
        formattedDate.maxIntakeDay()
    }
    
    var minIntakeDay: DrinkHistory? {
        formattedDate.minIntakeDay()
    }
    
    var averageGoal: Double {
        formattedDate.averageGoal()
    }
    
    var averageIntake: Double {
        formattedDate.averageIntake()
    }

    
    private func shouldHighlight(day: DrinkHistory) -> Bool {
        switch showCase {
        case .maxIntake:
            return day.drinkDate == maxIntakeDay?.drinkDate
        case .minIntake:
            return day.drinkDate == minIntakeDay?.drinkDate
            
        case .achievementRate:
            return day.isGoalAchefed == true
        default:
            return false
        }
    }

    private var foregroundColorForBar: Color {
        switch showCase {
        case .averageGoal, .averageIntake:
            return showCase.ChartMarkColor
        default:
            return .secondary.opacity(0.6)
        }
    }
    
    private var highlightText:String {
        switch showCase{
        case .achievementRate:
            return formattedDate.achievementRate().formatted(.percent)
        case .averageGoal:
            return averageGoal.formatted(.number)
        case .averageIntake:
            return averageIntake.formatted(.number.rounded())
        case .maxIntake:
            return maxIntakeDay?.drinkDate.formattedDate ?? ""
        case .minIntake:
            return minIntakeDay?.drinkDate.formattedDate ?? ""
            
        case .defaultValue:
            return formattedDate.totalIntake().formatted(.number.rounded())
        }
    }
    
    private func annotationText(for value: Double, description: String) -> Text {
        Text("\(description): \(value, specifier: "%.0f")")
            .font(.body.bold())
            .foregroundStyle(.orange)
    }
    
    var body: some View {
        VStack(alignment:.leading){
            GroupBox{
                    Text(highlightText)
                    font(.callout)
                    .foregroundStyle(.secondary)
                    
                
                .frame(maxWidth: .infinity)
                Chart {
                    ForEach(formattedDate, id: \.self) { day in
                        BarMark(
                            x: .value("Date", day.drinkDate, unit: .day),
                            y: .value("Intake", day.currentDrink),
                            width: .ratio(0.6)
                        )
                        
                        .clipShape(.rect(cornerRadius: 12))
                        .foregroundStyle(shouldHighlight(day: day) ? showCase.ChartMarkColor : showCase == .defaultValue ? .pointer : .pointer.opacity(0.4))
                        
                        if showCase == .achievementRate{
                            PointMark(
                                x: .value("Day", day.drinkDate),
                                y: .value("Goal", day.drinkGoal)
                            )
                            .foregroundStyle(day.isGoalAchefed ? .orange : .clear)
                        }
                        
                        
                    }
                    
                    
                    if showCase == .averageGoal {
                        RuleMark(y: .value("Average Goal", averageGoal))
                            .foregroundStyle(.orange)
                            .lineStyle(StrokeStyle(lineWidth: 3))
                            .annotation(position: .top, alignment: .leading) {
                                annotationText(for: averageGoal, description: "Average Goal")
                            }
                    }
                    
                    if showCase == .averageIntake {
                        RuleMark(y: .value("Average Intake", averageIntake))
                            .foregroundStyle(.teal)
                            .lineStyle(StrokeStyle(lineWidth: 3))
                            .annotation(position: .top, alignment: .leading) {
                                annotationText(for: averageIntake, description: "Average Intake")
                            }
                    }
                }
                .chartScrollableAxes(.horizontal)
                .chartXVisibleDomain(length: 3600 * 24 * 30)
                .chartScrollTargetBehavior(
                    .valueAligned(
                        matching: .init(hour: 0),
                        majorAlignment: .matching(.init(day: 1))))
                .chartScrollPosition(x: $scrollPosition)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day , count: 7)) {
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(format: .dateTime.month().day())
                    }
                }
                .frame(height: 300)
                
            }
            
            
                VStack(alignment:.leading,spacing: 4){
                    ForEach(ReportCases.allCases.prefix(5), id: \.self) { reportCase in
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)){
                                
                                showCase = reportCase
                            }
                        }label: {
                            HStack(alignment: .center){
                                Text(reportCase.reportCaseTitle)
                                Spacer()
                                
                            }
                            .padding(14)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(showCase == reportCase ? .white : .p1)
                            .background( showCase == reportCase ? Color.orange :Color.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0 ))
                            .opacity(0.3)
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(PlainButtonStyle())
                        
                        
                    }
            }
        }

    }
}

struct SelectableButtonStyle: ButtonStyle {

    var isSelected = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical,4)
        
    }
}
