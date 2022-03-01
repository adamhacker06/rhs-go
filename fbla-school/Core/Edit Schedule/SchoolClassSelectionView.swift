//
//  SchoolClassSelectionView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/6/22.
//

import SwiftUI

struct SchoolClassSelectionView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.showingSheet) var showingSheet
    
    @Binding var childPaddingAmount: CGFloat
    
    @State private var searchText: String = ""
    @State private var loadedClasses: [SchoolClass] = []
    
    let associatedEnum: SubjectsEnum
    let classPeriod: ClassPeriod
    
    private var searchResults: [SchoolClass] {
        if searchText.isEmpty {
            return loadedClasses.sorted(by: { $0.title < $1.title })
        } else {
            return loadedClasses
                .filter { $0.title.contains(searchText) || $0.administrator.contains(searchText) || $0.namePrefix.rawValue.contains(searchText) }
                .sorted(by: { $0.title < $1.title })
        }
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            List {
                
                ForEach(searchResults, id: \.self) { schoolClass in
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(schoolClass.title)
                                .foregroundColor(Color.theme.darkBlue)
                                .font(.custom("PublicSans-Bold", size: 18))
                            
                            Text(schoolClass.namePrefix.rawValue + " " + schoolClass.administrator.lastName())
                                .foregroundColor(Color.theme.lightBlue)
                                .font(.custom("PublicSans-Bold", size: 18))
                        }
                        .onTapGesture {
                        
                            data.scheduleDataManager.schedule.set(for: classPeriod, class: schoolClass)
                            
                            ScheduleDataManager.set(manager: data.scheduleDataManager)
                            print("set")
                            showingSheet?.wrappedValue = false
                            
                        }
                        
                        Spacer()
                    }
                    
                    
                }
                

            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                
                data.scheduleDataManager.cache.get(contentsOf: associatedEnum) { (classes, error) in
                    if let error = error {
                        print("error: \(error.localizedDescription)")
                    } else {
                        if let classes = classes {
                            loadedClasses = classes
                            data.scheduleDataManager.cache.set(items: classes, for: associatedEnum)
                        }
                    }
                }
            }
            
            Rectangle()
                .frame(height: childPaddingAmount)
                .foregroundColor(Color(UIColor.placeholderText))
            
        }
//        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(associatedEnum.rawValue)

    }
}
//
//struct SchoolClassSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SchoolClassSelectionView(associatedEnum: .academies, classPeriod: .first)
//    }
//}
