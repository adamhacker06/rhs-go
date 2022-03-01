//
//  SubjectsDataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import Foundation
import FirebaseFirestore

enum FirestoreSubjectFetchError: Error {
    case invalidPath
}

class SchoolClassesCache: Cache {
    typealias CacheType = SchoolClass
    typealias CacheEnumType = SubjectsEnum
    
    private var asbCache: [CacheType]? = nil
    private var academiesCache: [CacheType]? = nil
    private var cteCache: [CacheType]? = nil
    private var englishCache: [CacheType]? = nil
    private var foreignLanguageCache: [CacheType]? = nil
    private var mathCache: [CacheType]? = nil
    private var peCache: [CacheType]? = nil
    private var scienceCache: [CacheType]? = nil
    private var socialScienceCache: [CacheType]? = nil
    private var specialEducationCache: [CacheType]? = nil
    private var visualAndPerformingArtsCache: [CacheType]? = nil
    private var otherCache: [CacheType]? = nil
    
    internal func associatedCache(of schoolSubject: CacheEnumType) -> [CacheType]? {
        switch schoolSubject {
        case .ASB:
            return asbCache
        case .academies:
            return academiesCache
        case .CTE:
            return cteCache
        case .english:
            return englishCache
        case .foreignLanguage:
            return foreignLanguageCache
        case .math:
            return mathCache
        case .PE:
            return peCache
        case .science:
            return scienceCache
        case .socialScience:
            return socialScienceCache
        case .specialEduation:
            return specialEducationCache
        case .visualAndPerformingArts:
            return visualAndPerformingArtsCache
        case .other:
            return otherCache
        }
    }
    
    func get(contentsOf item: CacheEnumType, forceRefresh: Bool = false, completion: @escaping ([CacheType]?, FirestoreSubjectFetchError?) -> Void) {
        
        cacheHandler(item: item, collectionName: "subjects", documentName: item.rawValue, subCollectionName: "classes", forceRefresh: forceRefresh) { (classes, error) in
            
            completion(classes, error)
            
        }

    }
    
    func set(items: [CacheType], for type: CacheEnumType) {
        switch type {
        case .ASB:
            asbCache = items
        case .academies:
            academiesCache = items
        case .CTE:
            cteCache = items
        case .english:
            englishCache = items
        case .foreignLanguage:
            foreignLanguageCache = items
        case .math:
            mathCache = items
        case .PE:
            peCache = items
        case .science:
             scienceCache = items
        case .socialScience:
            socialScienceCache = items
        case .specialEduation:
            specialEducationCache = items
        case .visualAndPerformingArts:
            visualAndPerformingArtsCache = items
        case .other:
            otherCache = items
        }
    }
    
}

//struct RealtimeDatabaseManager {
//
//    enum RealtimeDatabaseUploadDataType {
//        case food
//        case subject
//    }
//
//    static func upload(type: RealtimeDatabaseUploadDataType) {
//        // write to
//    }
//
//    static func retrieveSubjects(subject: Subjects, completion: @escaping (String) -> Void) {
//
//        let db = Firestore.firestore()
//
//        db.collection("subjects").document(subject.rawValue).collection("classes").getDocuments { (snapshot, error) in
//            if error != nil {
//                print(error)
//            } else {
//
//            }
//        }
//    }
//}

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
