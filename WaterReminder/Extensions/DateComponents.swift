//
//  DateComponents.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 11/11/1445 AH.
//

import Foundation

extension DateComponents {
    static func dayAndTime(hour: Int, minute: Int, weekday: Int) -> DateComponents {
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        components.weekday = weekday
        return components
    }
}
