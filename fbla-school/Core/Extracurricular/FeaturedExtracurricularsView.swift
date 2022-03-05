//
//  FeaturedExtracurricularsView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 3/1/22.
//

import SwiftUI

struct FeaturedExtracurricularsView: View {
    
    @EnvironmentObject var data: DataManager
    
    @State private var loadedItems: [ExtracurricularModel] = []
    
    @State private var showAllExtracurriculars: Bool = false
    
    //    @State private var showTargetExtracurricular: Bool = false
    //    @State private var targetFood: Food = Food(type: .entree, name: "Unknown", portion: "Unknown", calories: "Unknown", sugars: "Unknown", protein: "Unknown", carbs: "Unknown", transFat: "Unknown")
    //
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            VStack(spacing: 5) {
                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    
                    Text("Featured Extracurriculars")
                        .font(.custom("PublicSans-SemiBold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    if !loadedItems.isEmpty {
                        Text("See all")
                            .underline()
                            .foregroundColor(.white)
                            .font(.custom("PublicSans-Regular", size: 16))
                            .onTapGesture {
                                showAllExtracurriculars = true
                            }
                    }
                    
                }
                
                CustomDivider(color: .white, thickness: 5)
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                if !loadedItems.isEmpty {
                    HStack(alignment: .center, spacing: 15) {
                        
                        ForEach(loadedItems, id: \.self) { extracurricular in
                            
                            ExtracurricularTileView(extracurricular: extracurricular, showBorder: false)
                                .frame(width: 300, height: 150)
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    
                } else {
                    
                    if data.extracurricularsDataManager.isUpdating {
                        ProgressView()
                    } else {
                        Text("Unable to load the featured extracurriculars")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                    }
                }
            }
            
        }
        .padding(.vertical, 20)
        .background {
            ZStack {
                
                NavigationLink("", isActive: $showAllExtracurriculars) {
                    AllExtracurricularsView()
                }
                
                Color.theme.rubyRed
            }
        }
        .onAppear {
            data.extracurricularsDataManager.cache.get(contentsOf: .featured) { (extracurriculars, error) in
                
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    
                } else {
                    if let extracurriculars = extracurriculars {
                        
                        data.extracurricularsDataManager.cache.set(items: extracurriculars, for: .featured)
                        loadedItems = extracurriculars
                        
                    }
                }
            }
        }
    }
}

struct FeaturedExtracurricularsView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedExtracurricularsView()
    }
}
