//
//  CustomDivider.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/22/21.
//

import SwiftUI
struct CustomDivider: View {
    
    var color: Color
    var thickness: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(color)
            .frame(height: thickness)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
