//
//  SandboxViewModel.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 11/20/21.
//

import SwiftUI
import FirebaseStorage

class SandboxViewModel {
    
    let storage = Storage.storage()
    
    func fetchImage(fileRef: String, completion: @escaping (URL) -> Void) {
        let ref = storage.reference(withPath: fileRef)
        
        ref.downloadURL { (url, error) in
            
            if let error = error {
                print(error.localizedDescription)
                print(error)
                return
            }
            
            if let url = url {
                completion(url)
            }
        }
    }
}
