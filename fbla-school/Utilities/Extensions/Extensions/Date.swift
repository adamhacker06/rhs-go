//
//  Date.swift
//  brainiacs-app
//
//  Created by Adam Hacker on 6/21/21.
//

import SwiftUI

// Date extension for use with Date value types
extension Date {
    
    static let cal = Calendar(identifier: .gregorian)
    
    static var currentFoodWeek: FoodWeek {
        
        let components = Date.cal.dateComponents([.weekOfYear], from: firstDayOfSchool, to: Date())
        
        if components.weekOfYear! == 0 {
            return .first
        } else {
            return .second
        }
    }
    
    static var firstDayOfSchool: Date {
        
        Date.cal.date(from: DateComponents(calendar: Date.cal, year: 2021, month: 8, day: 12))!
        
    }
    
    // Stores the int value of the past year (Ex: Current year is 2022, value returns 2021)
    static let lastYear = Date().getComponentFromDate(for: .year) - 1
    
    // Stores the int value of the current year (Ex: Current year is 2022, value returns 2022)
    static let thisYear = Date().getComponentFromDate(for: .year)
    
    // Returns a Date from the specified components. If failed, returns original Date the modifier was executed on
    func fromDateComponents(month: Int, day: Int, year: Int, hour: Int = 0, minute: Int = 0) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: "PST")
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // Create date from components
        let userCalendar = Calendar(identifier: .gregorian)
        return userCalendar.date(from: dateComponents) ?? self
    }
    
    // Returns an Int representing the specificed component of the Date executed on
    func getComponentFromDate(for selected: Calendar.Component) -> Int {
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        var returnedComponent: Int
        
        switch selected {
        
        case .year:
            returnedComponent = components.year!
            
        case .month:
            returnedComponent = components.month!
            
        case .day:
            returnedComponent = components.day!
            
        case .hour:
            returnedComponent = components.hour!
            
        case .minute:
            returnedComponent = components.minute!
            
        default:
            returnedComponent = 1
        }
        
        return returnedComponent
    }
    
    // Returns the computed property of the age of the Date executed on
    var age: Int {
        Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    static var currentWeekNumber: Int {
        Calendar.current.component(.weekOfMonth, from: Date())
        
    }
    
    // Returns a String of the Date executed on
    func asLongDateString() -> String {
        
        var longDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, y"
            return formatter.string(from: self)
        }
        
        return longDateString
    }
    
    func asShortTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    // Default date checker
    func matchesDefault() -> Bool {
        return self.asLongDateString() == Date().fromDateComponents(month: 1, day: 1, year: 2000).asLongDateString()
    }
}
