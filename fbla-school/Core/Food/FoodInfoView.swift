//
//  FoodInfoView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import SwiftUI

struct FoodInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let food: Food
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    
                    Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title.weight(.regular))
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30, maxHeight: 30)
                    })
                    
                    Spacer()
                    
                    Text("!")
                        .foregroundColor(.white)
                        .font(.custom("PublicSans-Medium", size: 16))
                        .frame(maxWidth: 30, maxHeight: 30)
                        .background(
                            Circle()
                                .strokeBorder(Color.theme.darkRed, lineWidth: 1)
                                .frame(maxWidth: 40, maxHeight: 40)
                                .background(Color.theme.orange.cornerRadius(.infinity))
                        )
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 0) {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(maxWidth: 150, maxHeight: 150)
                        .padding(.bottom, 15)
                    
                    Text(food.name!)
                        .font(.custom("PublicSans-Medium", size: 24))
                }
                .padding(.bottom, 35)
                
                VStack(spacing: 0) {
                    Text("Nutrition Information")
                        .foregroundColor(.white)
                        .font(.custom("PublicSans-Medium", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    
                    CustomDivider(color: .theme.darkRed, thickness: 5)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 10) {
                            FoodNutritionLabel(nutritionType: .portion, value: food.portion ?? "Unknown")
                            FoodNutritionLabel(nutritionType: .calories, value: food.calories ?? "Unknown")
                            FoodNutritionLabel(nutritionType: .sugars, value: food.sugars ?? "Unknown")
                            FoodNutritionLabel(nutritionType: .proteins, value: food.protein ?? "Unknown")
                            FoodNutritionLabel(nutritionType: .carbs, value: food.carbs ?? "Unknown")
                            FoodNutritionLabel(nutritionType: .transFat, value: food.transFat ?? "Unknown")
                        }
                        .padding(.top, 20)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding([.horizontal, .top], 20)
                .background(Color.orange.cornerRadius(30, corners: [.topLeft, .topRight]).shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: -4).ignoresSafeArea())
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct FoodInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FoodInfoView(food: Development.chickenSandwich).previewDevice("iPhone 12")
    }
}
