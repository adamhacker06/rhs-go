//
//  ClassPeriod.swift
//  RHS Go
//
//  Created by Adam Hacker on 4/13/22.
//

import Foundation

struct ClassPeriod: Codable, Equatable {
    
    let period: ClassPeriodEnum
    
    let start: String
    let end: String
}
