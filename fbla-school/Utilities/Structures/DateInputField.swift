//
//  DateInputField.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/16/21.
//

import SwiftUI

struct DateInputField: View {
    
    var title: String
    
    @Binding var date: Date
    @Binding var isActive: Bool
    
    init(_ title: String, selection: Binding<Date>, isActive: Binding<Bool>) {
        self.title = title
        self._date = selection
        self._isActive = isActive
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .fontWeight(date.matchesDefault() ? .none : .bold)
                .foregroundColor(date.matchesDefault() ? Color(.placeholderText) : .theme.lightBlue)
                .offset(y: date.matchesDefault() ? -7 : -25)
                .scaleEffect(date.matchesDefault() ? 1 : 0.8, anchor: .leading)
            
            Button(action: { withAnimation { isActive = true } } ) {
                Text(date.asLongDateString())
                    .opacity(date.matchesDefault() ? 0 : 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .offset(y: date.matchesDefault() ? -7 : 0)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 15)
        .animation(.default, value: date)
    }
}

struct DateInputField_Previews: PreviewProvider {
    static var previews: some View {
        DateInputField("", selection: .constant(Date()), isActive: .constant(true))
    }
}
