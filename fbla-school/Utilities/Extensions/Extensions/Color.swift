//
//  Color.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/11/21.
//

import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let emptyField = Color("EmptyField")
    
    // Get color from hex method
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    
    let gray = Color("GrayColor")
    
    let blue = Color("BlueColor")
    let blueInversed = Color("BlueColorInversed")
    
    let red = Color("RedColor")
    let redInversed = Color("RedColorInversed")
    
    let green = Color("GreenColor")
    let greenInversed = Color("GreenColorInversed")
    
    let lightGreen = Color("LighGreenColor")
    let lightGreenInversed = Color("LightGreenColorInversed")
    
    let spanishBlue = Color("SpanishBlueColor")
    let lapiz = Color("LapizColor")
    
    let lightBlue = Color("LightBlueColor")
    
    var asArray: [Color] {
        return [accent, blue, blueInversed, gray, red, redInversed, spanishBlue, lightBlue, lapiz, lightGreen, lightGreenInversed, green, greenInversed]
    }
    
}
