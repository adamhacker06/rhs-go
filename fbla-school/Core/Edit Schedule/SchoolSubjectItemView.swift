//
//  SchoolSubjectItemView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/31/22.
//

import SwiftUI

//struct SchoolClassSelectionViewModel {
//
//    var classes: [SchoolClass] = []
//    var searchText: String = ""
//
//    var searchResults: [SchoolClass] {
//        if searchText.isEmpty {
//            return classes
//        } else {
//            return classes.filter { $0.className.contains(searchText) || $0.teacher.contains(searchText) || $0.namePrefix.rawValue.contains(searchText) }
//        }
//    }
//
//}

struct ShowingAddClassSheetKey: EnvironmentKey {
    static let defaultValue: Binding<Bool>? = nil
}

struct ContentTypeKey: EnvironmentKey {
    static let defaultValue: MessageContentTypes? = nil
}

extension EnvironmentValues {
    var showingSheet: Binding<Bool>? {
            get { self[ShowingAddClassSheetKey.self] }
            set { self[ShowingAddClassSheetKey.self] = newValue }
        }
    
    var contentType: MessageContentTypes? {
        get { self[ContentTypeKey.self] }
        set { self[ContentTypeKey.self] = newValue }
    }
}

struct SchoolSubjectItemView: View {
    
    let associatedSubjectEnum: SubjectsEnum
    
    @Binding var childPaddingAmount: CGFloat
    
    @State private var showSelectionScreen: Bool = false
    
    let classPeriod: ClassPeriod
    
    var body: some View {
    
            
            
            HStack(alignment: .center) {
                
                Text(associatedSubjectEnum.emoji)
                    .padding()
                    .shadow(radius: 5)
                    .font(.largeTitle)
                    .frame(maxWidth: 70, maxHeight: 70)
                    .overlay(
                        Circle().stroke(Color.theme.lapiz, lineWidth: 2)
                    )
                
                Spacer(minLength: 30)
                
                VStack(alignment: .trailing, spacing: 0) {
                    Text(associatedSubjectEnum.rawValue)
                        .font(.custom("PublicSans-Bold", size: 18))
                        .foregroundColor(Color.theme.lapiz)
                    
                    Text(associatedSubjectEnum.description)
                        .font(.custom("PublicSans-Light", size: 14))
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                }
                
            }
            .padding(.bottom, associatedSubjectEnum == SubjectsEnum.allCases.last ? childPaddingAmount + 30 : 0)
            .onTapGesture {
                showSelectionScreen = true
            }
            .background {
                NavigationLink("", isActive: $showSelectionScreen) {
                    SchoolClassSelectionView(childPaddingAmount: $childPaddingAmount, associatedEnum: associatedSubjectEnum, classPeriod: classPeriod)
                }
            }
        
    }
}

struct SchoolSubjectItemView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolSubjectItemView(associatedSubjectEnum: SubjectsEnum.academies, childPaddingAmount: .constant(.zero), classPeriod: .first)
    }
}
