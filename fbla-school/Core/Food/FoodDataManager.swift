//
//  FoodUserDefaultsManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 10/3/21.
//

import Foundation

struct FoodDataManager: Codable {
    
    static func get() -> FoodDataManager? {
        let defaults = UserDefaults.standard
        
        if let managerData = defaults.object(forKey: "foodManager") as? Data {
        
            let decoder = JSONDecoder()
            
            if let loadedManager = try? decoder.decode(FoodDataManager.self, from: managerData) {
                return loadedManager
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func set(manager: FoodDataManager) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encodedManagerData = try? encoder.encode(manager) {
            defaults.set(encodedManagerData, forKey: "foodManager")
        }
    }
    
    var lastUpdated: Date
    var foods: [Food]?
    
    var isUpdating: Bool = false
    
}
