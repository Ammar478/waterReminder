//
//  DateExtensions.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import Foundation

extension Date {
    var firstLetterOfWeekDay:String{
        let formater = DateFormatter()
        formater.dateFormat = "EEEE"
        let weekDayName = formater.string(from: self)
        return String(weekDayName.prefix(3)).uppercased()
        
    }
    
    var formattedDate: String {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          return formatter.string(from: self)
      }
    
    var YearFormatter:String {
        let formater = DateFormatter()
        formater.dateFormat = "MMM dd, yyyy"
        return formater.string(from: self)
    }
    
    var MonthFormatter:String {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM, yyyy"
        return formater.string(from: self)
    }
    

}
