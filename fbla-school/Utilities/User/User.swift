//
//  User.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn

class User: ObservableObject {
    
    var firebaseUserObject: FirebaseAuth.User
    
    var profile: ProfileInfo
    
    init(user: FirebaseAuth.User) {
        self.firebaseUserObject = user
        self.profile = ProfileInfo(emailAddress: firebaseUserObject.email ?? "", displayName: firebaseUserObject.displayName ?? "")
    }
    
//    var googleUser: GIDGoogleUser?
//    let profileInfo: GoogleProfileInfo
    
//    init(withUser user: GIDGoogleUser) {
//        self.googleUser = user
//        self.profileInfo = GoogleProfileInfo(withUser: user)
////        self.schedule = nil
//    }
//
//    init(withDevUser user: DevUser, schedule: [ClassPeriod:SchoolClass]? = nil) {
//        self.googleUser = nil
//        self.profileInfo = GoogleProfileInfo(withDevUser: user)
////        self.schedule = schedule
//    }
    
}

struct ProfileInfo {
    let emailAddress: String
    let firstName: String? = nil
    let lastName: String? = nil
    
    let displayName: String
    
    var fullName: String {
        (firstName ?? "") + " " + (lastName ?? "")
    }
}

struct GoogleProfileInfo {
    
    let emailAddress: String
    let fullName: String
    let firstName: String?
    let lastName: String?
    
    init(withUser user: GIDGoogleUser) {
            self.emailAddress = user.profile!.email
            self.fullName = user.profile!.name
            self.firstName = user.profile!.givenName ?? nil
            self.lastName = user.profile!.familyName ?? nil
        
        print("First: \(firstName)")
        print("Last: \(lastName)")
    }
     
    init(withDevUser user: DevUser) {
        self.emailAddress = user.emailAddress
        self.fullName = user.fullName
        self.firstName = user.firstName
        self.lastName = user.lastName
    }
}

struct DevUser {
    let emailAddress: String
    let fullName: String
    let firstName: String?
    let lastName: String?
    
    init(email: String, firstName: String, lastName: String) {
        self.emailAddress = email
        self.fullName = firstName + " " + lastName
        
        self.firstName = firstName
        self.lastName = lastName

    }
}
