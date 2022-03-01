//
//  CheckboxView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/14/22.
//

import SwiftUI

struct CheckBoxView: View {
    
    var isChecked: () -> Bool
    
    var onSelect: () -> Void
    
    var body: some View {
        Button(action: {
            
            onSelect()
            
        }) {
            
            Rectangle()
                .foregroundColor(Color.theme.paleBlue)
                .opacity(isChecked() ? 1 : 0.4)
                .cornerRadius(5)
                .overlay {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .opacity(isChecked() ? 1 : 0)
                }
            
        }
        .frame(width: 35, height: 35)
    }
    
}

struct EmailCheckboxView: View {
    
    @Binding var selectedItems: Array<AnyInformation>
    
    var item: AnyInformation
    
    var emailList: [String] {
        
        var emailStore: [String] = []
        
        for item in selectedItems {
            emailStore.append(item.email)
        }
        
        return emailStore
    }
    
    private var isContained: Bool {
        emailList.contains(item.email)
    }
    
    var body: some View {
        
        Button(action: {
            
            if isContained {
                selectedItems.removeAll { $0.email == item.email}
            } else {
                selectedItems.append(item)
            }
            
        }) {
            
            Rectangle()
                .foregroundColor(Color.theme.paleBlue)
                .opacity(isContained ? 1 : 0.4)
                .cornerRadius(5)
                .overlay {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .opacity(isContained ? 1 : 0)
                }
            
        }
        .frame(width: 35, height: 35)
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        EmailCheckboxView(selectedItems: .constant([]), item: SchoolClass(administrator: "", namePrefix: .mr, title: "", email: ""))
    }
}
