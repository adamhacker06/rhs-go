//
//  TodaysFoodView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 10/3/21.
//

import SwiftUI
import simd

struct TodaysFoodView: View {
    
    let foods: [Food]
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 20) {
                VStack(spacing: 5) {
                    Text("Today's Lunch | Sep. 20")
                        .font(.custom("PublicSans-SemiBold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomDivider(color: .white, thickness: 5)
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(foods.indices) { index in
                            
                            FoodHomeTileView(food: foods[index])
                            
                        }
                    }
                    .padding(.leading, 20)
                }
                
            }
            .padding(.vertical, 20)
            .background( Color.theme.darkRed )
            
    }
}

struct FoodHomeTileView: View {
    
    let food: Food
    
    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: 125, maxHeight: 105)
                .foregroundColor(.white)
            
            Text(food.name!)
                .foregroundColor(.white)
                .font(.custom("PublicSans-SemiBold", size: 14))
        }
        .padding(10)
        .background(Color.theme.orange.cornerRadius(15))
    }
}

struct TodaysFoodView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysFoodView(foods: [Development.chickenSandwich, Development.chickenSandwich, Development.chickenSandwich])
    }
}
