//
//  Food.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import Foundation

struct Food: Identifiable, Codable {
    
    let id = UUID().uuidString
    
    var type: FoodType?
    
    var name: String?
    var portion: String?
    var calories: String?
    var sugars: String?
    var protein: String?
    var carbs: String?
    var transFat: String?
    
    enum CodingKeys: String, CodingKey {
        
        // Map the JSON key "url" to the Swift property name "htmlLink"
        case name
        case portion = "po"
        case calories = "ca"
        case sugars = "s"
        case protein = "pr"
        case carbs = "cb"
        case transFat = "tf"
        case type = "ty"
        
    }
}

enum FoodType: String, CaseIterable, Codable {
    case entree, side
}

enum FoodWeek: Int {
//    static var currentWeek: FoodWeek {
//        return FoodWeek(rawValue: Date.currentWeekNumber % 2)!
//    }
    
    
//    init(moduloResult: Int) throws {
//
//        if (moduloResult != 0 || moduloResult != 1) {
//            throw ValidationError.invalid
//        }
//
//        if moduloResult == 0 {
//            self.init(rawValue: 1)!
//        }
//
//    }
    
    init?(withFirebaseInterpretation week: String) {
        if week == "1" {
            self.init(rawValue: 0)!
        } else if week == "2" {
            self.init(rawValue: 1)!
        } else {
            return nil
        }
    }
    
    case first = 0
    case second = 1
}

enum ValidationError: Error {
    case invalid
}
