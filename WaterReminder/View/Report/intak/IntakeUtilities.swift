//
//  IntakeUtilities.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 05/11/1445 AH.
//

import Foundation
import SwiftUI


enum ReportCases:String,Hashable,CaseIterable{
    case averageIntake
    case averageGoal
    case achievementRate
    case maxIntake
    case minIntake
    case defaultValue
    
    
    
    var reportCaseTitle:String {
        switch self{
        case .averageGoal : return "Average Goal"
        case .averageIntake : return "Avertage Intake"
        case .achievementRate : return "Achievement Rate"
        case .maxIntake : return " Maximum Intake"
        case .minIntake : return "Minimum Intake "
        case .defaultValue:
            return ""
        }
    }
    
    var ChartMarkColor:Color {
        switch self {
        case .achievementRate : return .orange
        case .averageIntake:
            return .teal.opacity(0.5)
        case .averageGoal:
            return .orange.opacity(0.5)
        case .maxIntake:
            return .orange
        case .minIntake:
            return .teal
        case .defaultValue:
            return .pointer
        }
    }
    
}
