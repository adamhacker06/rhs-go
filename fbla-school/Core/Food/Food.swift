//
//  Food.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import Foundation

struct Food: Identifiable {
    
    let id = UUID().uuidString
    
    var type: FoodType?
    
    var name: String?
    var portion: String?
    var calories: String?
    var sugars: String?
    var protein: String?
    var carbs: String?
    var transFat: String?
}

enum FoodType: String, CaseIterable {
    case entree, side
}

enum FoodWeek: Int {
    static var currentWeek: FoodWeek {
        return FoodWeek(rawValue: Date.currentWeekNumber % 2)!
    }
    
    case first = 1
    case second = 0
}
