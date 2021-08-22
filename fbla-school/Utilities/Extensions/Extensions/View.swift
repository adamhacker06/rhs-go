//
//  View.swift
//  brainiacs-app
//
//  Created by Adam Hacker on 6/21/21.
//

import SwiftUI

#if canImport(UIKit)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

// View extension for use with View value types
public extension View {
    
    // Returns the size of the safe area
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // Returns a modified View with a corner radius. Custom-made to allow for specific corner selecting
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(size: radius, corners: corners) )
    }
    
    // Returns a modified View with a custom theme applied
    func generalInputFieldModifiers(_ color: Color = .white, shadow: Bool = true, maxWidth: CGFloat = UIScreen.main.bounds.width * 0.8) -> some View {
        return self
            .frame(maxWidth: maxWidth)
            .padding(10)
            .background(
            
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color)
                    .clipped()
                    .shadow(radius: shadow ? 10 : 0)
            
            )
    }
    
}

// Custom Shape which is primarily used with the custom cornerRadius View modifier
struct RoundedCorner: Shape {
    
    var size: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    var animatableData: CGFloat {
        get { size }
        set { self.size = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        return Path(path.cgPath)
    }
}
