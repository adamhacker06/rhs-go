//
//  MessageViewSubjectSelectionLabelView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/14/22.
//

import SwiftUI

struct MessageViewSubjectSelectionLabelView: View {
    
    @EnvironmentObject var vm: MessagingViewModel
    
    let contentType: MessageContentTypes
    let associatedSubject: ContentSubType
    
    @State private var showSelectionScreen: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            NavigationLink("", isActive: $showSelectionScreen) {
                EmailSelectionView(for: associatedSubject, contentType: contentType)
                    .environmentObject(vm)
                    .navigationTitle(associatedSubject.name)
                    .navigationBarTitleDisplayMode(.inline)
                
            }
            
            Button(action: {
                showSelectionScreen = true
            }) {
                CustomLabel(for: associatedSubject)
            }
        }
    }
}

struct MessageViewSubjectSelectionLabelView_Previews: PreviewProvider {
    static var previews: some View {
        MessageViewSubjectSelectionLabelView(contentType: .schoolClass, associatedSubject: SubjectsEnum.ASB)
    }
}
