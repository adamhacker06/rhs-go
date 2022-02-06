//
//  ScheduleDataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import Foundation

struct ScheduleDataManager: Codable {
    
    static func get() -> ScheduleDataManager? {
        let defaults = UserDefaults.standard
        
        if let managerData = defaults.object(forKey: "scheduleManager") as? Data {
        
            let decoder = JSONDecoder()
            
            if let loadedManager = try? decoder.decode(ScheduleDataManager.self, from: managerData) {
                return loadedManager
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func set(manager: ScheduleDataManager) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encodedManagerData = try? encoder.encode(manager) {
            defaults.set(encodedManagerData, forKey: "scheduleManager")
        }
    }
    
    var lastUpdated: Date
    var schedule: [ClassPeriod:SchoolClass]?
    
    var cache = SchoolClassesCache()
}
