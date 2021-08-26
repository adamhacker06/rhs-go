//
//  TextInputField.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/16/21.
//

import SwiftUI

struct TextInputField: View {
    
    var title: String
    
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .fontWeight(text.isEmpty ? .none : .bold)
                .foregroundColor(text.isEmpty ? Color(.placeholderText) : .theme.spanishBlue)
                .offset(y: text.isEmpty ? -7 : -25)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
            
            TextField("", text: $text)
                .offset(y: text.isEmpty ? -7 : 0)
        }
        .padding(.top, 15)
        .animation(.default, value: text.isEmpty)
    }
}

struct TextInputField_Previews: PreviewProvider {
    static var previews: some View {
        TextInputField("First name", text: .constant(""))
    }
}
