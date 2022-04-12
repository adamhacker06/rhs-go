//
//  CalendarAPIManager.swift
//  RHS Go
//
//  Created by Adam Hacker on 1/22/22.
//

import SwiftUI
import GoogleSignIn
import Combine

class CalendarAPIManager {
    
    private var cancellable: AnyCancellable?
    private static let sessionProcessingQueue = DispatchQueue(label: "CalendarSessionProcessingQueue")
     
    // The function used for sending an API call to the Google Calendar API
    // Returns a tuple of an optional GoogleAPICalendar model and an optional Error
    static func sendPublicGETRequest(completion: @escaping (GoogleAPICalendar?, Error?) -> Void) {
        
        // Accesses the API key in the app's info dictionary and stores it as a String
        if let apiKey = Bundle.main.infoDictionary?["GOOGLE_CALENDAR_API_KEY"] as? String {
            
            // Creates the URL to be used in the API call
            let url = URL(string: "https://www.googleapis.com/calendar/v3/calendars/c_74hh9q3ljg9ka060unme3fue48@group.calendar.google.com/events?key=\(apiKey)&orderBy=startTime&singleEvents=true&timeMin=\(Date.now.asDashedDateString())T00:00:00-08:00&maxResults=10")
            
            // Configures the network request (API call) to return the data in JSON format
            var request = URLRequest(url: url!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Creates and initiates the network request (API call)
            let _ = URLSession.shared.dataTaskPublisher(for: request)
            
                // Subscribes the process to a custom DispatchQueue
                .subscribe(on: Self.sessionProcessingQueue)
            
                // Returns the data as it is for the following processes
                .map({
                    return $0.data
                })
            
                // Takes the JSON data from the API call and decodes it into a custom "GoogleAPICalendar" model
                .decode(type: GoogleAPICalendar.self, decoder: JSONDecoder())
            
                // Indicates the app to handle the returning data on the main DispatchQueue
                .receive(on: DispatchQueue.main)
            
                // Handles the decoded GoogleAPICalendar model
                .sink(receiveCompletion: { (subscriberCompletion) in
                    switch subscriberCompletion {
                    case .finished:
                        break
                        
                    // If there was a failure...
                    case .failure(let error):
                        
                        // Send a completion where the result is nil (blank) and the error is describing what went wrong
                        completion(nil, error)
                    }
                }, receiveValue: { (calendar) in
                    
                    // When the decoding is successful and there is a resulting GoogleAPICalendar model...
                    // Send a completion where the result is the calendar and the error is nil (blank)
                    completion(calendar, nil)
                })
        }
    }
}
