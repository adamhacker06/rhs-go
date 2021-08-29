//
//  NumberInputField.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/18/21.
//

import SwiftUI

struct NumberInputField: View {
    
    var title: String
    
    @Binding var number: Int
    @Binding var isActive: Bool
    
    init(_ title: String, number: Binding<Int>, isActive: Binding<Bool>) {
        self.title = title
        self._number = number
        self._isActive = isActive
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .fontWeight(number.matchesYear(for: Date.lastYear) ? .none : .bold)
                .foregroundColor(number.matchesYear(for: Date.lastYear) ? Color(.placeholderText) : .theme.lightBlue)
                .offset(y: number.matchesYear(for: Date.lastYear) ? -7 : -25)
                .scaleEffect(number.matchesYear(for: Date.lastYear) ? 1 : 0.8, anchor: .leading)
            
            Button(action: { withAnimation { isActive = true } } ) {
                Text(number.description)
                    .opacity(number.matchesYear(for: Date.lastYear) ? 0 : 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .offset(y: number.matchesYear(for: Date.lastYear) ? -7 : 0)
            
        }
        .padding(.top, 15)
        .animation(.default, value: number)
    }
}

struct NumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        NumberInputField("High School Graduation year", number: .constant(2024), isActive: .constant(true))
    }
}
