//
//  String.swift
//  brainiacs-app
//
//  Created by Adam Hacker on 6/21/21.
//

import SwiftUI

public extension String {
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        print(Date(timeIntervalSince1970: -2207520000).asLongDateString())
        
        return formatter.date(from: self) ?? Date(timeIntervalSince1970: -2207520000)
    }
    
}
