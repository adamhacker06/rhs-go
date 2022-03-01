//
//  String.swift
//  brainiacs-app
//
//  Created by Adam Hacker on 6/21/21.
//

import SwiftUI

// String extension for use with String value types
public extension String {
    
    enum DateFormats: String {
        case ddMMyyyy = "dd/MM/yyyy HH:mm"
        case RFC3339 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case yyyyMMdd = "yyyy-MM-dd"
    
    }
    // Returns a Date from the String executed on. If failed, returns Jan 1 1900.
    func toDate(format: DateFormats = DateFormats.ddMMyyyy) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        return formatter.date(from: self) ?? Date(timeIntervalSince1970: -2208960000)
    }
    
    func toShortLocationForm() -> String {
        
        var string = self
        
        if let dotRange = string.range(of: ",") {
            string.removeSubrange(dotRange.lowerBound..<string.endIndex)
        }
        
        return string
    }
    
    func firstName() -> String {
        self.components(separatedBy: " ")[0]
    }
    
    func lastName() -> String {
        if self.components(separatedBy: " ").count >= 2 {
            return self.components(separatedBy: " ")[1]
        } else {
            return "Error"
        }
    } 
    
    // note to future adam: you are working on getting the time stuff and date stuff working for the calendar
    
//    func toRFC3339String() {
//        let RFC3339DateFormatter = DateFormatter()
//        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//
//        /* 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time) */
//        let string = "1996-12-19T16:39:57-08:00"
//        let date = RFC3339DateFormatter.date(from: string)
//    }
}
