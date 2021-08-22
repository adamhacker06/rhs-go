//
//  String.swift
//  brainiacs-app
//
//  Created by Adam Hacker on 6/21/21.
//

import SwiftUI

// String extension for use with String value types
public extension String {
    
    // Returns a Date from the String executed on. If failed, returns Jan 1 1900.
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        return formatter.date(from: self) ?? Date(timeIntervalSince1970: -2208960000)
    }
    
}
