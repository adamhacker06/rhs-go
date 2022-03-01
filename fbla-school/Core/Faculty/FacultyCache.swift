//
//  FacultyCache.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/13/22.
//

import Foundation

struct FacultyModel: AnyInformation, Codable, Equatable, Hashable {
 
    let administrator: String
    let namePrefix: NamePrefix
    let email: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case administrator = "name"
        case title = "designation"
        case namePrefix, email
    }
}

class FacultyCache: Cache {
    typealias CacheType = FacultyModel
    typealias CacheEnumType = FacultyTypesEnum
    
    private var adminCache: [CacheType]? = nil
    private var counselorsCache: [CacheType]? = nil
    
    func get(contentsOf item: CacheEnumType, forceRefresh: Bool = false, completion: @escaping ([CacheType]?, FirestoreSubjectFetchError?) -> Void) {
        
        cacheHandler(item: item, collectionName: "faculty", documentName: item.rawValue, subCollectionName: "people", forceRefresh: forceRefresh) { (people, error) in
            completion(people, error)
        }
        
    }
    
    func set(items: [CacheType], for type: CacheEnumType) {
        switch type {
        case .administration:
            adminCache = items
        case .counselors:
            counselorsCache = items
        }
    }
    
    func associatedCache(of type: CacheEnumType) -> [CacheType]? {
        switch type {
        case .administration:
            return adminCache
        case .counselors:
            return counselorsCache
        }
    }
}
