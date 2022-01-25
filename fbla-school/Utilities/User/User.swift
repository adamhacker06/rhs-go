//
//  User.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI
import GoogleSignIn

class User: ObservableObject {
    
    var googleUser: GIDGoogleUser?
    let profileInfo: GoogleProfileInfo
    
    let schedule: [ClassPeriod:SchoolClass]?
    
    var hasPrefirst: Bool {
        guard let _ = schedule?[ClassPeriod.prefirst] else { return false }
        return true
    }
    
    init(withUser user: GIDGoogleUser) {
        self.googleUser = user
        print("LOOK HERE! \(self.googleUser)")
        self.profileInfo = GoogleProfileInfo(withUser: user)
        self.schedule = nil
    }
    
    init(withDevUser user: DevUser, schedule: [ClassPeriod:SchoolClass]? = nil) {
        self.googleUser = nil
        self.profileInfo = GoogleProfileInfo(withDevUser: user)
        self.schedule = schedule
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
