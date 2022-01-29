//
//  SubjectsDataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import Foundation
import FirebaseFirestore

struct RealtimeDatabaseManager {
    
//    private var db = Database.database().reference()
    
    enum RealtimeDatabaseUploadDataType {
        case food
        case subject
    }
    
    static func upload(type: RealtimeDatabaseUploadDataType) {
        // write to
    }
    
    static func retrieveSubjects() {
        
    }
}

struct SubjectsJSON {
    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

    // MARK: - Welcome
    struct Welcome: Codable {
        let subjects: [[String: [Subject]]]
    }

    // MARK: - Subject
    struct Subject: Codable {
        let teacher: String
        let namePrefix: NamePrefix
        let className: String
    }

    enum NamePrefix: String, Codable {
        case mr = "Mr."
        case mrs = "Mrs."
        case ms = "Ms."
    }

}
