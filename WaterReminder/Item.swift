//
//  Item.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 22/10/1445 AH.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
