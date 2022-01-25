//
//  CalendarAPIManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/22/22.
//

import Foundation
import GoogleSignIn
import Combine

struct CalendarAPIManager {
    static func requestAdditionalScopes(scopes: [String], presenting: UIViewController,completion: @escaping (CalendarScopeResponse, GIDGoogleUser) -> Void ) {
        GIDSignIn.sharedInstance.addScopes(scopes, presenting: presenting) { (user, error) in
            guard error == nil else { print(error?.localizedDescription); return }
            guard let user = user else { print("no user"); return }
            
            if user.grantedScopes == nil || !user.grantedScopes!.contains("https://www.googleapis.com/auth/calendar.events.readonly") {
                completion(.declined, user)
            }
            
            completion(.accepted, user)
        }
    }
    
    static func sendGETRequest(token: String, completion: @escaping (String) -> Void) {
        let url = URL(string: "https://www.googleapis.com/calendar/v3/calendars/c_74hh9q3ljg9ka060unme3fue48@group.calendar.google.com")
        
        var request = URLRequest(url: url!)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    completion(jsonString)
                } else {
                    print("Error decoding")
                }
                
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
        
    }
    
    private var cancellable: AnyCancellable?
    private static let sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")
    
    static func sendPublicGETRequest(apiKey: String, completion: @escaping (GoogleAPICalendar) -> Void) {
        let url = URL(string: "https://www.googleapis.com/calendar/v3/calendars/c_74hh9q3ljg9ka060unme3fue48@group.calendar.google.com/events?key=\(apiKey)")
        
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let _ = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: Self.sessionProcessingQueue)
            .map({
                return $0.data
            })
            .decode(type: GoogleAPICalendar.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (suscriberCompletion) in
                switch suscriberCompletion {
                case .finished:
                    // do something that you want to do when finished
                    break
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            }, receiveValue: { (calendar) in
                completion(calendar)
            })
    }
}
