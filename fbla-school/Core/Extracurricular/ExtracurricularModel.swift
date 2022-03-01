//
//  ExtracurricularModel.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/27/22.
//

import Foundation

struct ExtracurricularModel: AnyInformation, Codable, Hashable {
    
    let email: String
    let title: String
    let administrator: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "advisorEmail"
        case title = "clubName"
        case administrator = "advisor"
        case description = "description"
    }
    
}
