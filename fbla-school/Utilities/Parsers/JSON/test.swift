//
//  test.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ClassData: Codable {
    let subjects: [[String: [SchoolClass]]]
}

struct SchoolClass: Codable {
    @DocumentID var id = UUID().uuidString
    let teacher: String
    let namePrefix: NamePrefix
    let className: String
}

enum NamePrefix: String, Codable {
    case mr = "Mr."
    case mrs = "Mrs."
    case ms = "Ms."
}

func parseSubjectsJSON(data: Data) {
    
    let db = Firestore.firestore()
    let collection = db.collection("subjects")
    
    let decoder = JSONDecoder()
    let data = try? decoder.decode(ClassData.self, from: data)
    
    for subject in data!.subjects {
        
        for (subjectName, classArray) in subject {
            
            let subjectPath = collection.document("\(subjectName)")
            
//            subjectPath.setData([
//                "subjectName":subjectName
//            ])
            
            print (subjectName)
            
            for schoolClass in classArray {
//                subjectPath.collection("classes").addDocument(data: [
//
//                    "className":schoolClass.className,
//                    "namePrefix":schoolClass.namePrefix.rawValue,
//                    "teacher":schoolClass.teacher
//
//                ])
                print(schoolClass.className + " is taught by " + schoolClass.teacher)
            }
        }
    }
}

func getSubjectJSONData() -> Data? {
    if let fileLocation = Bundle.main.url(forResource: "Subjects", withExtension: "json") {
        
        return try! Data(contentsOf: fileLocation)
        
    } else {
        return nil
    }
}
