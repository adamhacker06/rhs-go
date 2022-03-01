//
//  EmailSelectionView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/14/22.
//

import SwiftUI

struct EmailSelectionView: View {
    
    @EnvironmentObject var data: DataManager
    @EnvironmentObject var vm: MessagingViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var loadedItems: [AnyInformation] = []
    @State private var searchText: String = ""
    
    let target: ContentSubType
    let contentType: MessageContentTypes
    
    init(for target: ContentSubType, contentType: MessageContentTypes) {
        self.target = target
        self.contentType = contentType
        
    }
    
    var searchResults: [AnyInformation] {
        if searchText.isEmpty {
            return loadedItems.sorted(by: { $0.title < $1.title })
        } else {
            return loadedItems
                .filter { $0.title.contains(searchText) || $0.administrator.contains(searchText) }
                .sorted(by: { $0.title < $1.title })
        }
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //            HStack {
            //                Button(action: {
            //                    presentationMode.wrappedValue.dismiss()
            //                }) {
            //                    Image(systemName: "arrow.left")
            //                        .font(.title)
            //                }
            //
            //                Spacer()
            //                Text(target.name)
            //                    .font(.custom("PublicSans-Bold", size: 24))
            //                    .foregroundColor(Color.theme.lapiz)
            //            }
            //            .padding([.bottom, .horizontal])
            //            .background {
            //                Color.white.ignoresSafeArea()
            //                    .shadow(radius: 5)
            //            }
            
            ScrollView {
                
                switch contentType {
                case .schoolClass:
                    
                    VStack {
                        ForEach(searchResults as! [SchoolClass], id: \.self) { item in
                            EmailListItem(for: item, selectedItems: $vm.selectedItems)
                        }
                    }
                    .padding(.horizontal)
                    
                case .faculty:
                    
                    VStack {
                        ForEach(searchResults as! [FacultyModel], id: \.self) { item in
                            EmailListItem(for: item, selectedItems: $vm.selectedItems)
                        }
                    }
                    .padding(.horizontal)
                    
                case .extracurricular:
                    VStack {
                        ForEach(searchResults as! [ExtracurricularModel], id: \.self) { item in
                            EmailListItem(for: item, selectedItems: $vm.selectedItems)
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by name or title...")
            .onAppear {
                switch contentType {
                    
                case .schoolClass:
                    data.scheduleDataManager.cache.get(contentsOf: target as! SchoolClassesCache.CacheEnumType) { (classes, error) in
                        
                        if let error = error {
                            print("error: \(error.localizedDescription)")
                        } else {
                            if let classes = classes {
                                loadedItems = classes
                                data.scheduleDataManager.cache.set(items: classes, for: target as! SchoolClassesCache.CacheEnumType)
                            }
                        }
                        
                    }
                case .faculty:
                    
                    data.facultyDataManager.cache.get(contentsOf: target as! FacultyCache.CacheEnumType) { (people, error) in
                        if let error = error {
                            print("error: \(error.localizedDescription)")
                        } else {
                            if let people = people {
                                loadedItems = people
                                data.facultyDataManager.cache.set(items: people, for: target as! FacultyCache.CacheEnumType)
                            }
                        }
                    }
                    
                case .extracurricular:
                    
                    data.extracurricularsDataManager.cache.get(contentsOf: target as! ExtracurricularsCache.CacheEnumType) { (clubs, error) in
                        if let error = error {
                            print("error: \(error.localizedDescription)")
                        } else {
                            if let clubs = clubs {
                                loadedItems = clubs
                                data.extracurricularsDataManager.cache.set(items: clubs, for: target as! ExtracurricularsCache.CacheEnumType)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

struct EmailSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSelectionView(for: SubjectsEnum.ASB, contentType: .schoolClass)
    }
}
