//
//  FoodInfoView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import SwiftUI
import simd

extension View {
    func onFoodNutritionOverflow(completion: @escaping (Bool) -> ()) -> some View {
        onPreferenceChange(FoodNutritionOverflowPreferenceKey.self) { result in
            completion(result)
        }
    }
    
    func onFoodScrollResting(completion: @escaping (Bool) -> ()) -> some View {
        onPreferenceChange(FoodInfoScrollViewAtStartingPreferenceKey.self) { result in
            completion(result)
        }
    }
}

struct FoodInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isOverflown: Bool = false
    @State private var isScrollAtResting: Bool = true
    
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
                    
//                    Text("!")
//                        .foregroundColor(.white)
//                        .font(.custom("PublicSans-Medium", size: 16))
//                        .frame(maxWidth: 30, maxHeight: 30)
//                        .background(
//                            Circle()
//                                .strokeBorder(Color.theme.darkRed, lineWidth: 1)
//                                .frame(maxWidth: 40, maxHeight: 40)
//                                .background(Color.theme.orange.cornerRadius(.infinity))
//                        )
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 0) {
                    
                    Text(Date.now.withCustomFormat("M/d"))
                        .foregroundColor(Color.theme.orange)
                        .font(.custom("PublicSans-Bold", size: 40))
                        .padding(.vertical)
                    
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
                            FoodNutritionLabel(nutritionType: .portion, value: food.portion)
                            FoodNutritionLabel(nutritionType: .calories, value: food.calories)
                            FoodNutritionLabel(nutritionType: .sugars, value: food.sugars)
                            FoodNutritionLabel(nutritionType: .proteins, value: food.protein)
                            FoodNutritionLabel(nutritionType: .carbs, value: food.carbs)
                            FoodNutritionLabel(nutritionType: .transFat, value: food.transFat)
                            
                            Text("The data contained within this report should not be used for and does not provide menu planning for a child with a medical condition or food allergy. Please consult a medical professional for assistance in planning for or treating medical conditions.")
                                .font(.custom("PublicSans-Light", size: 14))
                                .italic()
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.white)
                            
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.preference(key: FoodNutritionOverflowPreferenceKey.self, value: (Screen.main.bounds.height - getSafeArea().bottom < geo.frame(in: .global).maxY ? true : false))
                                    }
                                )
                        }
                        .padding(.vertical, 20)
                        .background(
                            GeometryReader { geo in
                                
                                Color.clear.preference(key: FoodInfoScrollViewAtStartingPreferenceKey.self, value: geo.frame(in: .named("scroll")).minY == 0 ? true : false)
                                
                            }
                        )
                    }
                    .coordinateSpace(name: "scroll")
                    .onFoodNutritionOverflow { result in
                        isOverflown = result
                    }
                    .onFoodScrollResting { result in
                        isScrollAtResting = result
                    }
                    .disabled(!isOverflown && isScrollAtResting)
                    
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
        FoodInfoView(food: Development.chickenSandwich).previewDevice("iPhone SE (2nd generation)")
    }
}
