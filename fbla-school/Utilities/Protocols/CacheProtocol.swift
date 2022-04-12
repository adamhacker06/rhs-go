//
//  Protocol testing.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/13/22.
//

import Foundation
import SwiftUI


protocol FirebaseCache: Codable {
    associatedtype CacheType: Codable, Hashable
    
    associatedtype CacheEnumType: RawRepresentable, CaseIterable, Identifiable where CacheEnumType.RawValue == String
    
    var collectionName: String { get set }
    var subCollectionName: String { get set }
    
    /// - Parameters:
    ///     - contentsOf: The type of the `enum` which represents the data you want to retrieve
    ///     - forceRefresh: Determines whether the `
    func get(contentsOf item: CacheEnumType, forceRefresh: Bool, completion: @escaping ([CacheType]?, FirestoreSubjectFetchError?) -> Void)
    
    func set(items: [CacheType], for type: CacheEnumType)
    
    func associatedCache(of type: CacheEnumType) -> [CacheType]?
}

extension FirebaseCache {
    
    func cacheHandler(item: CacheEnumType, collectionName: String, documentName: String, subCollectionName: String, forceRefresh: Bool, completion: @escaping ([CacheType]?, FirestoreSubjectFetchError?) -> Void) {
        
        guard let cache = associatedCache(of: item) else {
            FirestoreDatabaseManager.retrieveSubjects(storeAs: CacheType.self, collectionName: collectionName, documentName: documentName, subCollectionName: subCollectionName) { (classes, error) in
                guard let classes = classes else {
                    completion(nil, .invalidPath)
                    return
                }
                
                completion(classes, nil)
                
            }
            
            return
            
        }
        
        if forceRefresh {
            FirestoreDatabaseManager.retrieveSubjects(storeAs: CacheType.self, collectionName: collectionName, documentName: documentName, subCollectionName: subCollectionName) { (classes, error) in
                guard let classes = classes else {
                    completion(nil, .invalidPath)
                    return
                }
                
                completion(classes, nil)
                
            }
        } else {
            completion(cache, nil)
        }
    }
    
    func get(contentsOf item: CacheEnumType, forceRefresh: Bool = false, completion: @escaping ([CacheType]?, FirestoreSubjectFetchError?) -> Void) {
        cacheHandler(item: item, collectionName: collectionName, documentName: item.rawValue, subCollectionName: subCollectionName, forceRefresh: forceRefresh) { (extracurriculars, error) in
            completion(extracurriculars, error)
        }
    }
    
}

protocol AnyInformation {
    var administrator: String { get }
    var email: String { get }
    var title: String { get }
    
}

protocol CustomLabelInformation {
    var emoji: String { get }
    var description: String { get }
    var name: String { get }
}


