//
//  Statistic.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 30/06/2024.
//


enum Statistic {
    case dailyAverage
    case weekdayAverage
    case weekendAverage
    case bestDay
    case defaultValue
    
    var title: String {
        switch self {
        case .dailyAverage:
            return "Daily Average"
        case .weekdayAverage:
            return "Weekday Average"
        case .weekendAverage:
            return "Weekend Average"
        case .bestDay:
            return "Best Hydration Day"
        case .defaultValue:
            return ""
        }
    }
}
