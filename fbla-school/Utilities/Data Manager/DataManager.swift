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
                self.user = User(withDevUser: DevUser(email: user.email!, firstName: user.displayName!, lastName: user.displayName!))
                completion(.signedIn)
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
