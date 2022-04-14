//
//  ClassPeriod.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/28/21.
//

import SwiftUI

enum ClassPeriodEnum: Int, Codable, CaseIterable {
    
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
    
//    struct PeriodDateComponent {
//
//        init(forPeriod period: ClassPeriod) {
//            self.period = period
//        }
//
//        let period: ClassPeriod
//
//        var currentPeriodTime: [String] {
//            return period.getTime(for: .starting).dropLast(5).string.components(separatedBy: ":")
//        }
//
//        var dateComponent: Date {
//            let currentDate = Date()
//            return Date().fromDateComponents(month: currentDate.getComponentFromDate(for: .month), day: currentDate.getComponentFromDate(for: .day), year: currentDate.getComponentFromDate(for: .year), hour: Int(currentPeriodTime[0])!, minute: Int(currentPeriodTime[1])!)
//        }
//    }
    
    func getTime(schedule bellSchedule: BellSchedule, for time: ClassPeriodEnum.TimeType) -> String {
        switch time {
        case .starting:
            
            switch self {
            
            case .prefirst:
                return bellSchedule.prefirst.start
            case .first:
                return bellSchedule.first.start
            case .second:
                return bellSchedule.second.start
            case .third:
                return bellSchedule.third.start
            case .fourth:
                return bellSchedule.fourth.start
            case .fifth:
                return bellSchedule.fifth.start
            case .sixth:
                return bellSchedule.sixth.start
            }
            
        case .ending:
            switch self {

            case .prefirst:
                return bellSchedule.prefirst.end
            case .first:
                return bellSchedule.first.end
            case .second:
                return bellSchedule.second.end
            case .third:
                return bellSchedule.third.end
            case .fourth:
                return bellSchedule.fourth.end
            case .fifth:
                return bellSchedule.fifth.end
            case .sixth:
                return bellSchedule.sixth.end
            }
        }
    }
}
