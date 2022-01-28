//
//  CalendarDataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/27/22.
//

import Foundation

struct CalendarDataManager: Codable {
    
    static func get() -> CalendarDataManager? {
        let defaults = UserDefaults.standard
        
        if let managerData = defaults.object(forKey: "calendarManager") as? Data {
        
            let decoder = JSONDecoder()
            
            if let loadedManager = try? decoder.decode(CalendarDataManager.self, from: managerData) {
                return loadedManager
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func set(manager: CalendarDataManager) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encodedManagerData = try? encoder.encode(manager) {
            defaults.set(encodedManagerData, forKey: "calendarManager")
        }
    }
    
    var lastUpdated: Date
    var calendar: GoogleAPICalendar?
}
