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
    
    enum Fonts: String {
        case publicSans = "PublicSans"
        
        enum CustomWeights: String {
            case thin = "Thin"
            case extraLight = "ExtraLight"
            case light = "Light"
            case regular = "Regular"
            case medium = "Medium"
            case semiBold = "SemiBold"
            case bold = "Bold"
            case extraBold = "ExtraBold"
            case black = "Black"
        }
    }
    
    func font(_ font: Fonts, weight: Fonts.CustomWeights, size: CGFloat) -> Text {
        self.font(.custom("\(font.rawValue)-\(weight.rawValue)", size: size))
    }
    
}

