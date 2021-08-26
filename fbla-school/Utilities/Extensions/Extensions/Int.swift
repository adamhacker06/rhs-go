//
//  Int.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/18/21.
//

import SwiftUI

// Int extension for use with Int value types
extension Int {
    
    func matchesYear(for selected: Int) -> Bool {
    
        Date().fromDateComponents(month: 1, day: 1, year: selected).getComponentFromDate(for: .year) == self
        
    }
}
