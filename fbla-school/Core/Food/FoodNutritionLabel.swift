//
//  FoodNutritionLabel.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import SwiftUI

enum FoodNutritionType: String, CaseIterable {
    case portion = "Portion Size"
    case calories = "Calories"
    case sugars = "Sugars"
    case proteins = "Proteins"
    case carbs = "Carbs (Carbohydrates)"
    case transFat = "Trans-Fatty Acids"
}

struct FoodNutritionLabel: View {
    
    let nutritionType: FoodNutritionType
    let value: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(nutritionType.rawValue)
                .font(.custom("PublicSans-Regular", size: 14))
                .foregroundColor(.white)
                .padding(.bottom, 3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(value)
                .font(.custom("PublicSans-Regular", size: 14))
                .foregroundColor(.black)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.theme.darkRed, lineWidth: 1).background(Color.white.cornerRadius(10)))
            
        }
    }
}

struct FoodNutritionLabel_Previews: PreviewProvider {
    static var previews: some View {
        FoodNutritionLabel(nutritionType: .calories, value: Development.chickenSandwich.calories!)
    }
}
