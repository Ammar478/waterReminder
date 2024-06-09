//
//  DrinkUtility.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import Foundation
import SwiftUI


enum DrinkTypes:String,Codable,CaseIterable{
    case tea
    case water
    case coffee
    case sparklingWater
    case juices
    
    
    var title: String {
        switch self {
        case .tea: return "Tea"
        case .water: return "Water"
        case .coffee: return "Coffee"
        case .sparklingWater: return "Sparkling Water"
        case .juices: return "Juice"
        }
    }
    
    var systemImage:String{
        switch self{
        case .tea: return "mug.fill"
        case .water: return "waterbottle.fill"
        case .coffee: return "cup.and.saucer.fill"
        case .sparklingWater: return "bubbles.and.sparkles.fill"
        case .juices: return "wineglass.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .tea:
            return Color(red: 200/255.0, green: 100/255.0, blue: 90/255.0)
        case .water:
            return Color(red: 160/255.0, green: 190/255.0, blue: 190/255.0)
        case .coffee:
            return Color(red: 140/255.0, green: 100/255.0, blue: 90/255.0)
        case .sparklingWater:
            return Color(red: 80/255.0, green: 140/255.0, blue: 160/255.0)
        case .juices:
            return Color(red: 255/255.0, green: 165/255.0, blue: 145/255.0)
        }
    }
    
    var healthImpact: String {
        switch self {
        case .water: return "Essential for hydration, no calories."
        case .juices: return "Provides vitamins but can be high in sugar."
        case .coffee: return "Can boost alertness but may cause dehydration if consumed in excess."
        case .tea: return "Generally hydrating with antioxidants, some types contain caffeine."
        case .sparklingWater: return "Hydrating but may contain added sugars or artificial flavors."
        }
    }
}

enum MetDailyGoal: String {
    case achieved = "achieved"
    case notAchieved = "notAchieved"
    
    var status: String {
        switch self {
        case .achieved:
            return "yes"
        case .notAchieved:
            return "no"
        }
    }
}
