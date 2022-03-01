//
//  MessageViewContentTypeLabelView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/14/22.
//

import SwiftUI

struct MessageViewContentTypeLabelView: View {
    
    @EnvironmentObject var vm: MessagingViewModel
    @State private var showSelectionScreen: Bool = false
    
    let associatedType: MessageContentTypes
    
    var body: some View {
        VStack(spacing: 0) {
            
            NavigationLink("", isActive: $showSelectionScreen) {
                
                MessageViewSubContentTypeLabelView(associatedType: associatedType)
                    .environmentObject(vm)
                
                //                            SchoolClassSelectionView(associatedEnum: associatedSubjectEnum, classPeriod: classPeriod)
            }
            
            Button(action: {
                showSelectionScreen = true
            }) {
                HStack(alignment: .center) {
                    
                    Text(associatedType.emoji)
                        .font(.title)
                        .shadow(radius: 5)
                        .frame(maxWidth: 45, maxHeight: 45)
                        .overlay(
                            Circle().strokeBorder(Color.theme.lapiz, lineWidth: 2)
                        )
                    
                    Spacer(minLength: 50)
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        Text(associatedType.rawValue)
                            .font(.custom("PublicSans-Bold", size: 18))
                            .foregroundColor(Color.theme.lapiz)
                        
                        Text(associatedType.description)
                        
                            .font(.custom("PublicSans-Light", size: 14))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
    }
}

//struct MessageViewContentTypeLabelView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageViewContentTypeLabelView(associatedType: .schoolClass)
//    }
//}
