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
    
    let lapiz = Color("LapizColor")
    
    let black = Color("BlackColor")
    let white = Color("WhiteColor")
    let darkerGreen = Color("DarkerGreenColor")
    let darkGreen = Color("DarkGreenColor")
    let lightGreen = Color("LightGreenColor")
    let purple = Color("PurpleColor")
    let lightPurple = Color("LightPurpleColor")
    let lightBlue = Color("LightBlueColor")
    let skyBlue = Color("SkyBlueColor")
    let candyPurple = Color("CandyPurpleColor")
    let orange = Color("OrangeColor")
    let darkRed = Color("DarkRedColor")
    
    var asArray: [Color] {
        return [lapiz, black, white, darkerGreen, darkGreen, lightGreen, purple, lightPurple, candyPurple, lightBlue, skyBlue]
    }
    
}
