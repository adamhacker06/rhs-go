//
//  ToggleField.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI

struct ToggleField: View {
    
    @Namespace var animation
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            
            
            if !isOn {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 16, height: 16)
                    .matchedGeometryEffect(id: "toggle", in: animation)
                    .onTapGesture {
                        isOn = true
                    }
                    
            } else {
                Circle()
                    .foregroundColor(.theme.lightBlue)
                    .frame(width: 16, height: 16)
                    .matchedGeometryEffect(id: "toggle", in: animation)
                    .onTapGesture {
                        isOn = false
                    }

            }
        }
        .frame(maxWidth: 40, maxHeight: 20, alignment: isOn ? .trailing : .leading)
        .padding(.horizontal, 2)
        .background(Color.theme.lapiz)
        .clipShape(Capsule())
    }
}

struct ToggleField_Previews: PreviewProvider {
    static var previews: some View {
        ToggleField(isOn: .constant(true))
    }
}
