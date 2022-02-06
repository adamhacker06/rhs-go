//
//  SchoolSubjectItemView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/31/22.
//

import SwiftUI

struct SchoolClassSelectionViewModel {
    
    var classes: [SchoolClass] = []
    var searchText: String = ""
    
    var searchResults: [SchoolClass] {
        if searchText.isEmpty {
            return classes
        } else {
            return classes.filter { $0.className.contains(searchText) || $0.teacher.contains(searchText) || $0.namePrefix.rawValue.contains(searchText) }
        }
    }
    
}

struct SchoolClassSelectionView: View {
    
    @EnvironmentObject var data: DataManager
    
    let associatedEnum: SubjectsEnum
    
    @State private var searchText: String = ""
    @State private var loadedClasses: [SchoolClass] = []
    
    private var searchResults: [SchoolClass] {
        if searchText.isEmpty {
            return loadedClasses
        } else {
            return loadedClasses.filter { $0.className.contains(searchText) || $0.teacher.contains(searchText) || $0.namePrefix.rawValue.contains(searchText) }
        }
    }
    
    var body: some View {
        
        VStack {
            
            List {
                
                ForEach(searchResults, id: \.id) { schoolClass in
                    
                    VStack(alignment: .leading) {
                        Text(schoolClass.className)
                            .foregroundColor(Color.theme.darkBlue)
                            .font(.custom("PublicSans-Bold", size: 18))
                        
                        Text(schoolClass.namePrefix.rawValue + " " + schoolClass.teacher.lastName())
                            .foregroundColor(Color.theme.lightBlue)
                            .font(.custom("PublicSans-Bold", size: 18))
                    }
                    .onTapGesture {
                        // refactor code to include schedule in the scheduleDataManage rather than the user method
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                
                data.scheduleDataManager.cache.get(schoolSubject: associatedEnum) { (classes, error) in
                    if let error = error {
                        print("error: \(error.localizedDescription)")
                    } else {
                        if let classes = classes {
                            loadedClasses = classes
                            data.scheduleDataManager.cache.set(schoolClasses: classes, schoolSubject: associatedEnum)
                        }
                    }
                }
            }
        }
        .navigationTitle(associatedEnum.rawValue)

    }
}

struct SchoolSubjectItemView: View {
    
    let associatedSubjectEnum: SubjectsEnum
    
    @Binding var childPaddingAmount: CGFloat
    
    @State private var showSelectionScreen: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink("", isActive: $showSelectionScreen) {
                SchoolClassSelectionView(associatedEnum: associatedSubjectEnum)
            }
            
            HStack(alignment: .top) {
                
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
        }
    }
}

struct SchoolSubjectItemView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolSubjectItemView(associatedSubjectEnum: SubjectsEnum.academies, childPaddingAmount: .constant(.zero))
    }
}
