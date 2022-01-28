//
//  DataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Combine

class DataManager: ObservableObject {
    
    var didChange = PassthroughSubject<DataManager, Never>()
    @Published var user: User? { didSet { self.didChange.send(self) }}
    @Published var database = DatabaseManager() { didSet { self.didChange.send(self) }}
    
    @Published var foodDataManager = FoodUserDefaultsManager(lastUpdated: Date(timeIntervalSince1970: 0), foods: nil) { didSet { self.didChange.send(self) }}
    
    @Published var calendarDataManager = CalendarDataManager(lastUpdated: Date(timeIntervalSince1970: 0), calendar: nil) { didSet { self.didChange.send(self) }}
    
    @Published var giganteaDataManager = GiganteaDataManager(lastUpdated: Date(timeIntervalSince1970: 0), gigantea: nil) { didSet { self.didChange.send(self) }}
    
    var handle: AuthStateDidChangeListenerHandle?
    
    convenience init() {
        self.init(withUser: nil)
    }

    init(withUser user: User?) {
        self.user = user
    }

    init(withDevUser user: DevUser, schedule: [ClassPeriod:SchoolClass]? = nil) {
        self.user = User(withDevUser: user, schedule: schedule)
    }
    
    deinit {
        unbind()
    }
    
    func listenForUser(completion: @escaping (AuthManager.SignInState) -> Void) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
               
                GIDSignIn.sharedInstance.restorePreviousSignIn { (user, error) in
                    guard let user = user else {
                        if let error = error {
                            print(error)
                        }
                        
                        completion(.signedOut)
                        return
                        
                    }
                    
                    self.user?.googleUser = user
                        
                }
                
                self.user = User(withDevUser: DevUser(email: user.email!, firstName: user.displayName!, lastName: user.displayName!))
                completion(.signedIn)
                
                // FIX THIS
            } else {
                print("No user found")
            }
        })
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
}
