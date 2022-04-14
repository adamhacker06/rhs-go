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

struct EditScheduleSubjectSelectionView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var childPaddingSize: CGFloat = .zero
    
    var classPeriod: ClassPeriodEnum
    
    var body: some View {
        ZStack {
            
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        clearButton
                        
                        CustomDivider(color: Color.init(hex: 0xf5f5f5), thickness: 5)
                        
                        ForEach(SubjectsEnum.allCases) { subjectEnum in
                            SchoolSubjectItemView(associatedSubjectEnum: subjectEnum, childPaddingAmount: $childPaddingSize, classPeriod: classPeriod)
                                .padding()
                        }
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
                    Spacer(minLength: 10)
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close")
                            .foregroundColor(Color.theme.lapiz)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    Spacer(minLength: 10)
                    
                    Text("Editing Period \(classPeriod.rawValue)")
                        .font(.custom("PublicSans-Bold", size: 24))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                    
                    Spacer(minLength: 10)
                    
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
                        Color.theme.lapiz.ignoresSafeArea()
                            .preference(key: EditScheduleFooterCompartmentSizePreferenceKey.self, value: proxy.size.height)
                            .onPreferenceChange(EditScheduleFooterCompartmentSizePreferenceKey.self) { preferences in
                                childPaddingSize = preferences
                            }
                    }
                }
                .shadow(radius: 10)
                
            }
        }
    }
}

extension EditScheduleSubjectSelectionView {
    private var clearButton: some View {
        
        Button(action: {
            presentationMode.wrappedValue.dismiss()
            
            data.scheduleDataManager.schedule.set(for: classPeriod, class: nil)
            
            ScheduleDataManager.set(manager: data.scheduleDataManager)
        }) {
            
            HStack {
                
                Spacer()
                
                Text("Reset Period")
                    .font(.custom("PublicSans-Bold", size: 18))
                    .foregroundColor(Color.theme.darkRed)
                
                Image(systemName: "xmark")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.darkRed)
        
            }
            .padding()
            
        }
    }
}

struct EditScheduleClassSelector_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleSubjectSelectionView(classPeriod: .first)
            .environmentObject(DataManager())
    }
}
