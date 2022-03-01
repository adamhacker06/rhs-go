//
//  EmailSelectionView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/14/22.
//

import SwiftUI

struct MessageViewSubContentTypeLabelView: View {
    
    @EnvironmentObject var data: DataManager
    @EnvironmentObject var vm: MessagingViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let associatedType: MessageContentTypes
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                }
                
                Spacer()
                Text(associatedType.rawValue)
                    .font(.custom("PublicSans-Bold", size: 24))
                    .foregroundColor(Color.theme.lapiz)
            }
            .padding([.bottom, .horizontal])
            .background {
                Color.white.ignoresSafeArea()
                    .shadow(radius: 5)
            }
            
            ScrollView {
                
                switch associatedType {
                case .schoolClass:
                    
                    ForEach(SubjectsEnum.allCases) { subject in
                        MessageViewSubjectSelectionLabelView(contentType: associatedType, associatedSubject: subject)
                            .environmentObject(vm)
                    }
                    .padding()
                    
                case .faculty:
                    
                    ForEach(FacultyTypesEnum.allCases) { facultyType in
                        MessageViewSubjectSelectionLabelView(contentType: associatedType, associatedSubject: facultyType)
                            .environmentObject(vm)
                    }
                    .padding()
                    
                case .extracurricular:
                    
                    ForEach(ExtracurricularsTypesEnum.allCases) { extracurricularType in
                        MessageViewSubjectSelectionLabelView(contentType: associatedType, associatedSubject: extracurricularType)
                            .environmentObject(vm)
                    }
                    .padding()
                    
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

//struct MessageViewSubContentTypeLabelView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageViewSubContentTypeLabelView(associatedType: .schoolClass)
//    }
//}
