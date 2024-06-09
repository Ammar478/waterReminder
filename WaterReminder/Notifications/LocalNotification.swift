//
//  LocalNotification.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 10/11/1445 AH.
//

import Foundation

struct LocalNotification {
    var identifier: String
    var title: String
    var body: String
    var timeInterval: Double?
    var dateComponents: DateComponents?
    var repeats: Bool
}
