//
//  GenderInputField.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/16/21.
//

import SwiftUI

struct GenderInputField: View {
    
    var title: String
    
    @Binding var gender: String
    @Binding var isActive: Bool
    
    init(_ title: String, selection: Binding<String>, isActive: Binding<Bool>) {
        self.title = title
        self._gender = selection
        self._isActive = isActive
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .fontWeight(gender.isEmpty ? .none : .bold)
                .foregroundColor(gender.isEmpty ? Color(.placeholderText) : .theme.lightBlue)
                .offset(y: gender.isEmpty ? -7 : -25)
                .scaleEffect(gender.isEmpty ? 1 : 0.8, anchor: .leading)
            
            Button(action: { withAnimation { isActive = true } } ) {
                Text(gender)
                    .opacity(gender.isEmpty ? 0 : 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .offset(y: gender.isEmpty ? -7 : 0)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 15)
        .animation(.default, value: gender)
    }
    
}

struct GenderInputField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.lightBlue.ignoresSafeArea()
            GenderInputField("Select your gender", selection: .constant(""), isActive: .constant(true))
        }
    }
}
