//
//  AllExtracurricularsView.swift
//  RHS Go
//
//  Created by Adam Hacker on 3/3/22.
//

import SwiftUI

struct AllExtracurricularsView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var loadedFeaturedExtracurriculars: [ExtracurricularModel] = []
    @State private var allLoadedClubs: [ExtracurricularModel] = []
    
    private var allClubsGridItemLayout = [GridItem(.fixed(150)), GridItem(.fixed(150)), GridItem(.fixed(150))]
    
    private var featuredExtracurricularsGridItemLayout = [GridItem(.fixed(150)), GridItem(.fixed(150))]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            headerComponents
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0) {
                    featuredSection
                    clubsSection
                }
                .padding(.vertical)
            }
            
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

extension AllExtracurricularsView {
    
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("All Extracurriculars")
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.rubyRed.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
    
    private var featuredSection: some View {
        VStack(spacing: 10) {
            Text("Featured Clubs")
                .font(.custom("PublicSans-Medium", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHGrid(rows: featuredExtracurricularsGridItemLayout, spacing: 10) {
                    
                    ForEach(loadedFeaturedExtracurriculars, id: \.self) { club in
                        ExtracurricularTileView(extracurricular: club)
                            .frame(width: 300, height: 150)
                    }
                }
                .padding(.horizontal, 10)
                
            }
        }
    }
    
    private var clubsSection: some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                
                Text("All Clubs")
                    .font(.custom("PublicSans-Medium", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: allClubsGridItemLayout, spacing: 10) {
                        
                        ForEach(allLoadedClubs, id: \.self) { club in
                            ExtracurricularTileView(extracurricular: club)
                                .frame(width: 300, height: 150)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
            }
        }
        .onAppear {
            data.extracurricularsDataManager.cache.get(contentsOf: .featured) { (extracurriculars, error) in
                
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    
                } else {
                    if let extracurriculars = extracurriculars {
                        
                        data.extracurricularsDataManager.cache.set(items: extracurriculars, for: .featured)
                        loadedFeaturedExtracurriculars = extracurriculars
                        
                    }
                }
                
            }
            
            data.extracurricularsDataManager.cache.get(contentsOf: .clubs) { (extracurriculars, error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    
                } else {
                    if let extracurriculars = extracurriculars {
                        
                        data.extracurricularsDataManager.cache.set(items: extracurriculars, for: .clubs)
                        allLoadedClubs = extracurriculars
                        
                    }
                }
            }
        }
    }
}

struct AllExtracurricularsView_Previews: PreviewProvider {
    static var previews: some View {
        AllExtracurricularsView()
            .environmentObject(DataManager())
    }
}
