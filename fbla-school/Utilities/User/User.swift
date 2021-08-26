//
//  User.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI
import GoogleSignIn

class User: ObservableObject {
    
    let user: GIDGoogleUser
    let profileInfo: GoogleProfileInfo
    
    init(withUser user: GIDGoogleUser) {
        self.user = user
        self.profileInfo = GoogleProfileInfo(withUser: user)
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
}
