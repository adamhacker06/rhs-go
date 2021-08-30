//
//  DataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI
import GoogleSignIn
import Combine

class DataManager: ObservableObject {
    
    @Published var user: User?
    
    convenience init() {
        self.init(withUser: nil)
    }

    init(withUser user: User?) {
        self.user = user
    }

    init(withDevUser user: DevUser, schedule: [ClassPeriod:SchoolClass]? = nil) {
        self.user = User(withDevUser: user, schedule: schedule)
    }
}
