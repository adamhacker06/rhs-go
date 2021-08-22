//
//  Color.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/11/21.
//

import SwiftUI

// Color extension for use with Color value types
extension Color {
    
    // Initializes the color theme
    static let theme = ColorTheme()
    
    // Get color from hex
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

// Struct containing the color theme
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
    
    // An array containing all of the colors in the theme
    var asArray: [Color] {
        return [accent, blue, blueInversed, gray, red, redInversed, spanishBlue, lightBlue, lapiz, lightGreen, lightGreenInversed, green, greenInversed]
    }
    
}
