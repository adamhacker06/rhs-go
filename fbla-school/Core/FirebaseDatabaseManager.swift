//
//  FirebaseDatabaseManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/13/22.
//

import Foundation
import FirebaseFirestore

struct FirestoreDatabaseManager {
    
    static func retrieveSubjects<T: Codable>(storeAs type: T.Type, collectionName: String, documentName: String, subCollectionName: String, completion: @escaping ([T]?, Error?) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection(collectionName).document(documentName).collection(subCollectionName).getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else {
                print("No " + subCollectionName + " found in user's Firestore document.")
                return
            }
            
            let classes = documents.compactMap({ (queryDocumentSnapshot) -> T? in
                
                return try? queryDocumentSnapshot.data(as: T.self)
                
            })
            
            completion(classes, nil)
            
        }
    }
}
