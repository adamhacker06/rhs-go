//
//  FoodTileView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import SwiftUI

struct ExtracurricularTileView: View {
    
    @State private var showExtracurricularInfoView = false
    
    let extracurricular: ExtracurricularModel
    
    let showBorder: Bool
    
    init(extracurricular: ExtracurricularModel, showBorder: Bool = true) {
        self.extracurricular = extracurricular
        self.showBorder = showBorder
    }
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                Text(extracurricular.title)
                    .font(.custom("PublicSans-Medium", size: 20))
                    .foregroundColor(Color.theme.radicalRed)
                
                Spacer(minLength: 0)
                
                Text(extracurricular.administrator)
                    .font(.custom("PublicSans-Light", size: 18))
                    .foregroundColor(Color.theme.black)
                    
                //            Spacer()
              
                
            }
            
            Spacer(minLength: 0)
        }
        .padding(20)
        .background {
            
            ZStack {
                NavigationLink("", isActive: $showExtracurricularInfoView) {
                    ExtracurricularInfoView(extracurricular: extracurricular)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                }
                
                Color.white
                    .cornerRadius(5)
                    .padding(showBorder ? 10 : 0)
                    .zIndex(1)
                
                if showBorder {
                    Color.theme.radicalRed
                        .cornerRadius(5)
                }
                
            }
    
        }
        .onTapGesture {
            showExtracurricularInfoView = true
        }
    }
}

struct FoodTileView: View {
    
    @State private var showFoodInfoView = false
    
    let food: Food
    
    let showBorder: Bool
    
    init(food: Food, showBorder: Bool = true) {
        self.food = food
        self.showBorder = showBorder
    }
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                Text(food.name ?? "No name")
                    .font(.custom("PublicSans-Medium", size: 20))
                    .foregroundColor(Color.theme.orange)
                
                Spacer(minLength: 0)
                
                Text(food.type?.rawValue.capitalized ?? "No type")
                    .font(.custom("PublicSans-Regular", size: 20))
                    .foregroundColor(Color.theme.black)
                    
                //            Spacer()
                
                Text(food.calories ?? "Unknown")
                    .font(.custom("PublicSans-Light", size: 18))
                    .foregroundColor(Color.theme.black)
                
            }
            
            Spacer(minLength: 0)
        }
        .padding(20)
        .background {
            
            ZStack {
                NavigationLink("", isActive: $showFoodInfoView) {
                    FoodInfoView(food: food)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                }
                
                Color.white
                    .cornerRadius(5)
                    .padding(showBorder ? 10 : 0)
                    .zIndex(1)
                
                if showBorder {
                    Color.theme.darkRed
                        .cornerRadius(5)
                }
            }
    
        }
        .onTapGesture {
            showFoodInfoView = true
        }
    }
}

struct FoodTileView_Previews: PreviewProvider {
    static var previews: some View {
        FoodTileView(food: Development.chickenSandwich)
    }
}
