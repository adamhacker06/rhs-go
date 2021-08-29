//
//  User.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI
import GoogleSignIn

class User: ObservableObject {
    
    let googleUser: GIDGoogleUser?
    let profileInfo: GoogleProfileInfo
    
//    let schedule:
    
    init(withUser user: GIDGoogleUser) {
        
        self.googleUser = user
        self.profileInfo = GoogleProfileInfo(withUser: user)
        
    }
    
    init(withDevUser user: DevUser) {
        self.profileInfo = GoogleProfileInfo(withDevUser: user)
        self.googleUser = nil
    }
}

struct Schedule {
    var prefirst: SchoolClass
    var first: SchoolClass
    var second: SchoolClass
    var third: SchoolClass
    var fourth: SchoolClass
    var fifth: SchoolClass
    var sixth: SchoolClass
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
