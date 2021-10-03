//
//  FoodNutritionOverflowPreferenceKey.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 10/2/21.
//

import SwiftUI

struct FoodNutritionOverflowPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
    
}
