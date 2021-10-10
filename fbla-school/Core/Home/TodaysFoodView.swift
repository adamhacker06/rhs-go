//
//  TodaysFoodView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 10/3/21.
//

import SwiftUI
import simd

struct TodaysFoodView: View {
    
    @Binding var foods: [Food]?
    
    @State private var showAllFood: Bool = false
    
    var body: some View {
        
        ZStack {
            
            NavigationLink(
                "",
                isActive: $showAllFood) {
                    AllFoodView()
                        
                }
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(spacing: 5) {
                    HStack(alignment: .lastTextBaseline, spacing: 0) {
                        
                        Text("Today's Lunch | \(Date().withCustomFormat("MMM d."))")
                            .font(.custom("PublicSans-SemiBold", size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        if let foods = foods {
                            Text("See more")
                                .underline()
                                .foregroundColor(.white)
                                .font(.custom("PublicSans-Normal", size: 16))
                                .onTapGesture {
                                    showAllFood = true
                                }
                        }

                    }
                    
                    CustomDivider(color: .white, thickness: 5)
                }
                .padding(.horizontal, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 15) {
                        
                        if let foods = foods {
                            ForEach(foods.indices, id: \.self) { index in
                                
                                FoodHomeTileView(food: foods[index])
                                
                            }
                        } else {
                            Text("Unable to get today's lunch")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .disabled(foods == nil ? true : false)
            }
            .padding(.vertical, 20)
            .background( Color.theme.darkRed )
        }
    }
}

struct FoodHomeTileView: View {
    
    let food: Food
    
    var body: some View {
        VStack(spacing: 10) {
            
            
            RoundedRectangle(cornerRadius: 15)
                .frame(idealWidth: 125, maxWidth: .infinity, idealHeight: 105)
                .foregroundColor(.white)
                .overlay(
                    
                    EmptyView()
                    
                )
            
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
        TodaysFoodView(foods: .constant([Development.chickenSandwich, Development.chickenSandwich, Development.chickenSandwich]))
    }
}
