//
//  PullDownIndicator.swift
//  chore-tracker
//
//  Created by Adam Hacker on 7/6/21.
//

import SwiftUI

struct PullDownIndicator: View {
    
    var color: Color
    var height: CGFloat = 8
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundColor(color)
                .frame(maxWidth: Screen.main.bounds.width * 0.75, maxHeight: height)
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}

struct PullDownIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.accent.ignoresSafeArea()
            PullDownIndicator(color: .white)
        }
    }
}
