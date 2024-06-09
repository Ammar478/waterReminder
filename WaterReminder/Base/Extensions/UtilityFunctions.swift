//
//  UtilityFunctions.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 05/11/1445 AH.
//

import Foundation


public func isDifferentDay(_ date1: Date, from date2: Date) -> Bool {
    !Calendar.current.isDate(date1, inSameDayAs: date2)
}

enum TimeRange{
    case lastWeek
    case last30Days
    case last12Months
    
    var rangeUnit:Calendar.Component{
        switch self {
        case .last12Months : return .month
        case .last30Days : return .weekOfMonth
        case .lastWeek : return .day
        }
    }
    
    
}
