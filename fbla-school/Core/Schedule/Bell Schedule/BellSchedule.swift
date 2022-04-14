//
//  BellSchedule.swift
//  RHS Go
//
//  Created by Adam Hacker on 4/13/22.
//

import Foundation

struct BellSchedule: Codable, Equatable {
    
    init(dates: [Date] = [], oldSchedule: BellSchedule) {
        self.dates = dates
        self.prefirst = oldSchedule.prefirst
        self.first = oldSchedule.first
        self.second = oldSchedule.second
        self.third = oldSchedule.third
        self.fourth = oldSchedule.fourth
        self.fifth = oldSchedule.fifth
        self.sixth = oldSchedule.sixth
    }
    
    init(dates: [Date] = [], prefirst: ClassPeriod, first: ClassPeriod, second: ClassPeriod, third: ClassPeriod, fourth: ClassPeriod, fifth: ClassPeriod, sixth: ClassPeriod) {
        
        self.dates = dates
        self.prefirst = prefirst
        self.first = first
        self.second = second
        self.third = third
        self.fourth = fourth
        self.fifth = fifth
        self.sixth = sixth
        
    }
    
    let dates: [Date]
    
    var prefirst: ClassPeriod
    var first: ClassPeriod
    var second: ClassPeriod
    var third: ClassPeriod
    var fourth: ClassPeriod
    var fifth: ClassPeriod
    var sixth: ClassPeriod
    
    static var regularSchedule = BellSchedule(
        prefirst: ClassPeriod(period: .prefirst, start: "7:03", end: "8:00"),
        first: ClassPeriod(period: .first, start: "8:10", end: "9:07"),
        second: ClassPeriod(period: .second, start: "9:17", end: "10:16"),
        third: ClassPeriod(period: .third, start: "10:26", end: "11:23"),
        fourth: ClassPeriod(period: .fourth, start: "11:33", end: "12:30"),
        fifth: ClassPeriod(period: .fifth, start: "1:16", end: "2:13"),
        sixth: ClassPeriod(period: .sixth, start: "2:23", end: "3:20"))
    
    static func == (lhs: BellSchedule, rhs: BellSchedule) -> Bool {
        (lhs.prefirst == rhs.prefirst) && (lhs.first == rhs.first) && (lhs.second == rhs.second) && (lhs.third == rhs.third) && (lhs.fourth == rhs.fourth) && (lhs.fifth == rhs.fifth) && (lhs.sixth == rhs.sixth)
    }
    
}
