//
//  SubjectsDataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import Foundation
import FirebaseFirestore

class SchoolClassesCache: Codable {
    
    enum FirestoreSubjectFetchError: Error {
        case invalidPath
    }
    
    private var asbCache: [SchoolClass]? = nil
    private var academiesCache: [SchoolClass]? = nil
    private var cteCache: [SchoolClass]? = nil {
        didSet {
            print("set ctecache")
        }
    }
    private var englishCache: [SchoolClass]? = nil
    private var foreignLanguageCache: [SchoolClass]? = nil
    private var mathCache: [SchoolClass]? = nil
    private var peCache: [SchoolClass]? = nil
    private var scienceCache: [SchoolClass]? = nil
    private var socialScienceCache: [SchoolClass]? = nil
    private var specialEducationCache: [SchoolClass]? = nil
    private var visualAndPerformingArtsCache: [SchoolClass]? = nil
    private var otherCache: [SchoolClass]? = nil
    
    private func associatedCache(schoolSubject: SubjectsEnum) -> [SchoolClass]? {
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
    
    func get(schoolSubject: SubjectsEnum, forceRefresh: Bool = false, completion: @escaping ([SchoolClass]?, FirestoreSubjectFetchError?) -> Void) {
        
        switch schoolSubject {
        case .ASB:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)
                    
                }
                
                return
                
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .academies:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .CTE:
           print("CTE!!")
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    print("got from firebase")
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                print("got from cache")
                completion(cache, nil)
            }
            
        case .english:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .foreignLanguage:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .math:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .PE:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .science:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .socialScience:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .specialEduation:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .visualAndPerformingArts:
        
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
            } else {
                completion(cache, nil)
            }
            
        case .other:
            
            guard let cache = associatedCache(schoolSubject: schoolSubject) else {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
                    guard let classes = classes else {
                        completion(nil, .invalidPath)
                        return
                    }
                    
                    completion(classes, nil)

                }
                
                return
            }
            
            if forceRefresh {
                FirestoreDatabaseManager.retrieveSubjects(subject: schoolSubject) { (classes, error) in
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
    }
    
    func set(schoolClasses: [SchoolClass], schoolSubject: SubjectsEnum) {
        switch schoolSubject {
        case .ASB:
            asbCache = schoolClasses
        case .academies:
            academiesCache = schoolClasses
        case .CTE:
            cteCache = schoolClasses
        case .english:
            englishCache = schoolClasses
        case .foreignLanguage:
            foreignLanguageCache = schoolClasses
        case .math:
            mathCache = schoolClasses
        case .PE:
            peCache = schoolClasses
        case .science:
             scienceCache = schoolClasses
        case .socialScience:
            socialScienceCache = schoolClasses
        case .specialEduation:
            specialEducationCache = schoolClasses
        case .visualAndPerformingArts:
            visualAndPerformingArtsCache = schoolClasses
        case .other:
            otherCache = schoolClasses
        }
    }
}

struct FirestoreDatabaseManager {
    
    static func retrieveSubjects(subject: SubjectsEnum, completion: @escaping ([SchoolClass]?, Error?) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("subjects").document(subject.rawValue).collection("classes").getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else {
                print("No chores (documents) found in user's Firestore document.")
                return
            }
            
            let classes = documents.compactMap({ (queryDocumentSnapshot) -> SchoolClass? in
                
                return try? queryDocumentSnapshot.data(as: SchoolClass.self)
                
            })
            
            completion(classes, nil)
            
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
