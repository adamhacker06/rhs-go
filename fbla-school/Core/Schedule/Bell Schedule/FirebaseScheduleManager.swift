//
//  FirebaseScheduleManager.swift
//  RHS Go
//
//  Created by Adam Hacker on 4/13/22.
//

import Foundation
import FirebaseFirestore

class FirebaseScheduleManager {
    
    enum FirebaseScheduleFetchError: Error {
        case errorGettingDocuments
        case invalidData
        case noFirstDocument
    }
    
    static func getDaysFromFirebase(completion: @escaping (([Date], BellSchedule)?, FirebaseScheduleFetchError?) -> Void ) {
        
        let db = Firestore.firestore()
        
        let bellScheduleRef = db.collection("bell_schedule")
        
        let scheduleQuery = bellScheduleRef.whereField("days", arrayContains: Date.now.fromDateComponents(month: Date.now.getComponentFromDate(for: .month), day: Date.now.getComponentFromDate(for: .day), year: Date.now.getComponentFromDate(for: .year)))
        
        scheduleQuery
            .getDocuments { (snapshot, error) in
                if let err = error {
                    print("Error getting documents: \(err)")
                    completion(nil, .errorGettingDocuments)
                    
                } else {
                    
                    if let document = snapshot!.documents.first?.data() {
                        guard
                            let dates = document["days"] as? [Timestamp],
                              let periods = document["periods"] as? [String:[String:String]] else {
                            
                            print("Something is not right with the data")
                            completion(nil, .invalidData)
                            return
                        }
                        
                        var bellSchedule = BellSchedule.regularSchedule
                        
                        for period in periods {
                            
                            let periodName = period.0
                            
                            switch periodName {
                                
                            case "prefirst":
                                bellSchedule.prefirst = ClassPeriod(period: .prefirst, start: period.1["start"] ?? "?", end: period.1["end"] ?? "?")
                                
                            case "first":
                                bellSchedule.first = ClassPeriod(period: .first, start: period.1["start"] ?? "?", end: period.1["end"] ?? "?")
                                
                            case "second":
                                bellSchedule.second = ClassPeriod(period: .second, start: period.1["start"] ?? "?", end: period.1["end"] ?? "?")
                                
                            case "third":
                                bellSchedule.third = ClassPeriod(period: .third, start: period.1["start"] ?? "?", end: period.1["end"] ?? "?")
                                
                            case "fourth":
                                bellSchedule.fourth = ClassPeriod(period: .fourth, start: period.1["start"] ?? "?", end: period.1["end"] ?? "?")
                                
                            case "fifth":
                                bellSchedule.fifth = ClassPeriod(period: .fifth, start: period.1["start"] ?? "?", end: period.1["end"] ?? "?")
                                
                            case "sixth":
                                bellSchedule.sixth = ClassPeriod(period: .sixth, start: period.1["start"] ?? "?", end: period.1["end"] ?? "?")
                                
                            default:
                                break
                            }
                            
                        }
                        
                        print("before the completion to send the dates and bell schedule")
                        completion((dates.map( { $0.dateValue() } ), bellSchedule) , nil)
                    } else {
                        print("no first document")
                        completion(nil, .noFirstDocument)
                    }
                    
                }
            }
    }
}
