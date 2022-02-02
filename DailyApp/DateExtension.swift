//
//  DateExtension.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 28/01/2022.
//

import Foundation


extension Date {
  
  func dateAt(hours: Int, minutes: Int) -> Date {
    
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    
    var dateComponents = calendar.components(
      [NSCalendar.Unit.year,
       NSCalendar.Unit.month,
       NSCalendar.Unit.day]
      , from: self)

    dateComponents.hour = hours
    dateComponents.minute = minutes
    dateComponents.second = 0

    let newDate = calendar.date(from: dateComponents)!

    return newDate
  }
  
}
