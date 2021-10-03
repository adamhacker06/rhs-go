//
//  FoodInfoScrollViewAtStartingPreferenceKey.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 10/2/21.
//

import SwiftUI

struct FoodInfoScrollViewAtStartingPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = true
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
    
}
