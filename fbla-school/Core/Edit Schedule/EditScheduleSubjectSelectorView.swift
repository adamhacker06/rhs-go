//
//  EditScheduleClassSelector.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import SwiftUI

struct EditScheduleFooterCompartmentSizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct EditScheduleSubjectSelectorView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var childPaddingSize: CGFloat = .zero
    
    var classPeriod: ClassPeriod
    
    var body: some View {
        ZStack {
            
            NavigationView {
                ScrollView {
                    ForEach(SubjectsEnum.allCases) { subjectEnum in
                        SchoolSubjectItemView(associatedSubjectEnum: subjectEnum, childPaddingAmount: $childPaddingSize, classPeriod: classPeriod)
                            .padding()
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            
            VStack {
                
                Spacer()
                
                HStack {
                    
//                    Image(systemName: "xmark")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color.theme.darkRed)
//
//                    Spacer()
                    
                    Text("Editing Period \(classPeriod.rawValue)")
                        .font(.custom("PublicSans-Bold", size: 24))
                        .foregroundColor(Color.theme.white)
                    
//                    Spacer()
//
//                    Image(systemName: "checkmark")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color.theme.darkGreen)
//
                    
                }
                .padding()
                .background {
                    GeometryReader { proxy in
                        Color.theme.lapiz.cornerRadius(10)
                            .preference(key: EditScheduleFooterCompartmentSizePreferenceKey.self, value: proxy.size.height)
                            .onPreferenceChange(EditScheduleFooterCompartmentSizePreferenceKey.self) { preferences in
                                childPaddingSize = preferences
                            }
                    }
                }
                .padding()
                .shadow(radius: 10)
                
            }
        }
    }
}

struct EditScheduleClassSelector_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleSubjectSelectorView(classPeriod: .first)
            .environmentObject(DataManager())
    }
}
