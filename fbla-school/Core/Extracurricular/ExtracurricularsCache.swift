//
//  ExtracurricularsCache.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/27/22.
//

import Foundation

class ExtracurricularsCache: Cache {
    
    typealias CacheType = ExtracurricularModel
    typealias CacheEnumType = ExtracurricularsTypesEnum
    
    private var clubsCache: [CacheType]? = nil
    private var featuredCache: [CacheType]? = nil
    
    internal func associatedCache(of type: CacheEnumType) -> [CacheType]? {
        switch type {
        case .clubs:
            return clubsCache
        
        case .featured:
            return featuredCache
        }
    }
    
    func get(contentsOf item: CacheEnumType, forceRefresh: Bool = false, completion: @escaping ([CacheType]?, FirestoreSubjectFetchError?) -> Void) {
        cacheHandler(item: item, collectionName: "extracurriculars", documentName: item.rawValue, subCollectionName: "clubs", forceRefresh: forceRefresh) { (extracurriculars, error) in
            completion(extracurriculars, error)
        }
    }
    
    func set(items: [CacheType], for type: CacheEnumType) {
        switch type {
        case .clubs:
            clubsCache = items
            
        case .featured:
            featuredCache = items
        }
    }
}

enum ExtracurricularsTypesEnum: String, Identifiable, CaseIterable, ContentSubType {
   
    case featured = "Featured"
    case clubs = "Clubs"
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .clubs:
            return self.rawValue
        case .featured:
            return self.rawValue
        }
    }
    
    var emoji: String {
        switch self {
        case .clubs:
            return "🎓"
        case .featured:
            return "⭐️"
        }
    }
    
    var description: String {
        switch self {
        case .clubs:
            return "Some of the amazing clubs you'll find on campus."
        case .featured:
            return "A few extracurricular activities hand selected by our staff team."
        }
    }
    
}
