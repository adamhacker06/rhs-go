//
//  Date.swift
//  brainiacs-app
//
//  Created by Adam Hacker on 6/21/21.
//

import SwiftUI

public extension Date {
    
    static let lastYear = Date().getComponentFromDate(for: .year) - 1
    
    static let thisYear = Date().getComponentFromDate(for: .year)
    
    static let currentLastGraduationYear = Date.thisYear + 14
    
    /// Creates a Date from the specified components. If failed, returns the current date and time.
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
        return userCalendar.date(from: dateComponents) ?? Date()
    }
    
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
    
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    
    
    func asLongDateString() -> String {
        
        var longDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, y"
            return formatter.string(from: self)
        }
        
        return longDateString
    }
    
    func yearAsInt() -> Int {
        
        var yearString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            return formatter.string(from: self)
        }
        
        return Int(yearString) ?? 2021
        
    }
    
    func matchesDefault() -> Bool {
        return self.asLongDateString() == Date().fromDateComponents(month: 1, day: 1, year: 2000).asLongDateString()
    }
    
    
}
