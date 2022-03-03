//
//  ExtracurricularsDataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/21/22.
//

import Foundation

struct ExtracurricularsDataManager: Codable {
    
    static func get() -> ExtracurricularsDataManager? {
        let defaults = UserDefaults.standard
        
        if let managerData = defaults.object(forKey: "extracurricularsManager") as? Data {
        
            let decoder = JSONDecoder()
            
            if let loadedManager = try? decoder.decode(ExtracurricularsDataManager.self, from: managerData) {
                return loadedManager
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func set(manager: ExtracurricularsDataManager) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encodedManagerData = try? encoder.encode(manager) {
            defaults.set(encodedManagerData, forKey: "extracurricularsManager")
        }

    }
    
    var lastUpdated: Date
    
    var cache = ExtracurricularsCache()
    
    var isUpdating: Bool = false
}
