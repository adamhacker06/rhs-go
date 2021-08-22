//
//  Text.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/13/21.
//

import SwiftUI

// Text extension for use with Text value types
extension Text {
    
    // Returns a modified Text on the Text executed on with some general modifies
    func generalModifiers() -> some View {
        return self
            .lineLimit(1)
            .multilineTextAlignment(.center)
    }
}
