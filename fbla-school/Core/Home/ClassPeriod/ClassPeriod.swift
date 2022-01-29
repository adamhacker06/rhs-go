//
//  ClassPeriod.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/28/21.
//

import SwiftUI

struct test {
    let completionHandler: (ClassPeriod) -> Void = { period in
        
    }
}

enum ClassPeriod: Int, Codable, CaseIterable {
    
    enum TimeType {
        case starting
        case ending
    }
    
    case prefirst = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    case fifth = 5
    case sixth = 6
    
//    func current() -> ClassPeriod {
//
//        let classes = ClassPeriod.allCases
//
//        for index in 0..<classes.count {
//            if PeriodDateComponent(forPeriod: classes[index]).dateComponent <= Date() && Date() <= PeriodDateComponent(forPeriod: classes[index]).dateComponent {
//                return classes[index]
//            }
//        }
//    }
    
    struct PeriodDateComponent {
        
        init(forPeriod period: ClassPeriod) {
            self.period = period
        }
        
        let period: ClassPeriod
        
        var currentPeriodTime: [String] {
            return period.getTime(for: .starting).dropLast(5).string.components(separatedBy: ":")
        }
        
        var dateComponent: Date {
            let currentDate = Date()
            return Date().fromDateComponents(month: currentDate.getComponentFromDate(for: .month), day: currentDate.getComponentFromDate(for: .day), year: currentDate.getComponentFromDate(for: .year), hour: Int(currentPeriodTime[0])!, minute: Int(currentPeriodTime[1])!)
        }
    }
    
    func getTime(for time: ClassPeriod.TimeType) -> String {
        switch time {
        case .starting:
            
            switch self {
            
            case .prefirst:
                return String("7:03 A.M.")
            case .first:
                return String("8:10 A.M")
            case .second:
                return String("9:17 A.M")
            case .third:
                return String("10:26 A.M")
            case .fourth:
                return String("11:33 A.M")
            case .fifth:
                return String("1:16 P.M")
            case .sixth:
                return String("2:23 P.M")
            }
            
        case .ending:
            switch self {

            case .prefirst:
                return String("8:00 A.M.")
            case .first:
                return String("9:07 A.M.")
            case .second:
                return String("10:16 A.M.")
            case .third:
                return String("11:23 A.M.")
            case .fourth:
                return String("12:30 P.M.")
            case .fifth:
                return String("2:13 P.M.")
            case .sixth:
                return String("3:20 P.M.")
            }
        }
    }
}
