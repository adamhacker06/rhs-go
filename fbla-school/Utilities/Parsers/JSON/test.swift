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

struct SchoolClass: AnyInformation, Codable, Equatable, Hashable {
    
    //@DocumentID var id = UUID().uuidString
    let administrator: String
    let namePrefix: NamePrefix
    let title: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case administrator = "teacher"
        case title = "className"
        case namePrefix, email
    }
    
}

enum NamePrefix: String, Codable {
    case mr = "Mr."
    case mrs = "Mrs."
    case ms = "Ms."
    case none = ""
}

func parseSubjectsJSON(data: Data) {
    
    let db = Firestore.firestore()
    let collection = db.collection("extracurriculars")
    
    //let decoder = JSONDecoder()
    //let data = try? decoder.decode(ClassData.self, from: data)
    
    /*for subject in data!.subjects {
        
        for (subjectName, classArray) in subject {
            
            let subjectPath = collection.document("\(subjectName)")
            
            subjectPath.setData([
                "subjectName":subjectName
            ])
            
            print (subjectName)
            
            for schoolClass in classArray {
                
                subjectPath.collection("classes").addDocument(data: [

                    "className":schoolClass.className,
                    "namePrefix":schoolClass.namePrefix.rawValue,
                    "teacher":schoolClass.teacher,
                    "email":schoolClass.email

                ])
                    
                print(schoolClass.className + " is taught by " + schoolClass.teacher)
            }
        }
    }*/
    
    let data = [
    
        "FBLA":("Jacob Avila", "Mr.", "Future Business Leaders of America", "javila01@vusd.org"),
        "Athletes Giving Back":("Lizel Bettencourt", "Mrs.", "Athletes Giving Back", "lbettencourt01@vusd.org"),
        "Badminton Club":("Zach Adams", "Mr.", "Badminton Club", "zadams@vusd.org"),
        "Band Club":("Jordan Ray", "Mr.", "Band Club", "jray@vusd.org"),
        "Choir Club":("Mel Carillo", "Mr.", "Choir Club", "mcarrillo03@vusd.org"),
        "CSF":("Georgette Cheatwood", "Mrs.", "California Scholarship Federation", "gcheatwood@vusd.org"),
        "FFA":("John Coon", "Mr.", "Future Farmers of America", "jcoon@vusd.org"),
        "Mock Trial":("Zach Adams", "Mr.", "Mock Trial", "zadams@vusd.org")
    
    ]
    
    for (club, data) in data {
        let clubPath = collection.document("\(club)")
        
        print("Starting \(club)")
        
        clubPath.setData([
            "advisor":data.0,
            "advisorNamePrefix":data.1,
            "name":data.2,
            "advisorEmail":data.3
            
        ])
        
        print("Finished \(club)")
        
    }
}

func getSubjectJSONData() -> Data? {
    if let fileLocation = Bundle.main.url(forResource: "Subjects", withExtension: "json") {
        
        return try! Data(contentsOf: fileLocation)
        
    } else {
        return nil
    }
}
