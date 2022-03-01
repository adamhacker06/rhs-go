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
    
//    @Published var user: Redwood_HS_Helper.User? { didSet { self.didChange.send(self) }}
    @Published var database = DatabaseManager() { didSet { self.didChange.send(self) }}
    
    @Published var foodDataManager = FoodDataManager(lastUpdated: Date(timeIntervalSince1970: 0), foods: nil) { didSet { self.didChange.send(self) }}
    
    @Published var calendarDataManager = CalendarDataManager(lastUpdated: Date(timeIntervalSince1970: 0), calendar: nil) { didSet { self.didChange.send(self) }}
    
    @Published var giganteaDataManager = GiganteaDataManager(lastUpdated: Date(timeIntervalSince1970: 0), gigantea: nil) { didSet { self.didChange.send(self) }}
    
    @Published var scheduleDataManager = ScheduleDataManager(lastUpdated: Date(timeIntervalSince1970: 0)) { didSet { self.didChange.send(self) }}
    
    @Published var facultyDataManager = FacultyDataManager(lastUpdated: Date(timeIntervalSince1970: 0)) { didSet { self.didChange.send(self) }}
    
    @Published var extracurricularsDataManager = ExtracurricularsDataManager(lastUpdated: Date(timeIntervalSince1970: 0)) { didSet { self.didChange.send(self) }}
    
    var handle: AuthStateDidChangeListenerHandle?
    
//    convenience init() {
//        self.init(withUser: nil)
//    }

//    init(withUser user: User?) {
//        self.user = user
//    }

//    init(withDevUser user: DevUser) {
//        self.user = User(withDevUser: user)
//
//    }
    
    deinit {
        unbind()
    }
    
    /*func listenForUser(completion: @escaping (AuthManager.SignInState) -> Void) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, returnedUser) in
            
            if let user = auth.currentUser {
                
                if user.providerData.contains(where: { $0.providerID == "google.com" }) {
                
                    GIDSignIn.sharedInstance.restorePreviousSignIn { (googleReturnedUser, error) in
                        guard let _ = googleReturnedUser else {
                            if let error = error {
                                print(error)
                            }
                            
                            completion(.signedOut)
                            return
                            
                        }
                        
                        self.user = User(user: user)
                        completion(.signedIn)
                            
                    }
                    
                } else {
                    
                    self.user = User(user: user)
                    completion(.signedIn)
                    
                }
            }
            
//            var googleUserStore: GIDGoogleUser? = nil
//
//            if let customUser = returnedUser {
//
//                GIDSignIn.sharedInstance.restorePreviousSignIn { (googleReturnedUser, error) in
//                    guard let user = googleReturnedUser else {
//                        if let error = error {
//                            print(error)
//                        }
//
//                        completion(.signedOut)
//                        return
//
//                    }
//
//                    googleUserStore = googleReturnedUser
//
//                }
//
////                self.user = customUser
////                self.user?.googleUser = googleUserStore
//
////                self.user = user
//
//                self.user = User(user: googl)
//
//                self.user = User(withDevUser: DevUser(email: customUser.email ?? "", firstName: customUser.displayName, lastName: customUser.displayName!))
//
//                completion(.signedIn)
                
                // FIX THIS
//            } else {
//                print("No user found")
//            }
        })
    }*/
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
}
