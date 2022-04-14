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
    
    var schedule = ClassSchedule()
//    var schedule: [ClassPeriod : SchoolClass] = [:]
    
//    var hasPrefirst: Bool {
//        guard let _ = schedule[ClassPeriod.prefirst] else { return false }
//        return true
//    }
    
    var cache = SchoolClassesCache()
    
    var showPrefirst: Bool = false
}

struct ClassSchedule: Codable {
    
    init(prefirst: SchoolClass? = nil, first: SchoolClass? = nil, second: SchoolClass? = nil, third: SchoolClass? = nil, fourth: SchoolClass? = nil, fifth: SchoolClass? = nil, sixth: SchoolClass? = nil) {
        self.prefirst = prefirst
        self.first = first
        self.second = second
        self.third = third
        self.fourth = fourth
        self.fifth = fifth
        self.sixth = sixth
    }
    
    private var prefirst: SchoolClass? = nil
    private var first: SchoolClass? = nil
    private var second: SchoolClass? = nil
    private var third: SchoolClass? = nil
    private var fourth: SchoolClass? = nil
    private var fifth: SchoolClass? = nil
    private var sixth: SchoolClass? = nil
    
    var bellSchedule = BellSchedule.regularSchedule
    
    mutating func set(for period: ClassPeriodEnum, class item: SchoolClass?) {
        switch period {
        case .prefirst:
            prefirst = item
        case .first:
            first = item
        case .second:
            second = item
        case .third:
            third = item
        case .fourth:
            fourth = item
        case .fifth:
            fifth = item
        case .sixth:
            sixth = item
        }
    }
    
    var isEmpty: Bool {
        (prefirst == nil) && (first == nil) && (second == nil) && (third == nil) && (fourth == nil) && (fifth == nil) && (sixth == nil)
    }
    
    func get(for period: ClassPeriodEnum) -> SchoolClass? {
        switch period {
        case .prefirst:
            return prefirst
        case .first:
            return first
        case .second:
            return second
        case .third:
            return third
        case .fourth:
            return fourth
        case .fifth:
            return fifth
        case .sixth:
            return sixth
        }
    }
}

struct FacultyDataManager: Codable {
    
    static func get() -> FacultyDataManager? {
        let defaults = UserDefaults.standard
        
        if let managerData = defaults.object(forKey: "facultyManager") as? Data {
        
            let decoder = JSONDecoder()
            
            if let loadedManager = try? decoder.decode(FacultyDataManager.self, from: managerData) {
                return loadedManager
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func set(manager: FacultyDataManager) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encodedManagerData = try? encoder.encode(manager) {
            defaults.set(encodedManagerData, forKey: "facultyManager")
        }

    }
    
    var lastUpdated: Date
    
    var cache = FacultyCache()
}
