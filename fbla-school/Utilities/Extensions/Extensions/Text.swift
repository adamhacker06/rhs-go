//
//  Text.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/13/21.
//

import SwiftUI

extension Text {
    func generalModifiers() -> some View {
        return self
            .lineLimit(1)
            .multilineTextAlignment(.center)
    }
}
