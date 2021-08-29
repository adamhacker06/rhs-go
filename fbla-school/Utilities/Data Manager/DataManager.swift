//
//  DataManager.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI

class DataManager: ObservableObject {
    
    @Published var user: User?
    @Published var auth: AuthenticationViewModel
    
    convenience init() {
        self.init(withUser: nil)
    }
    
    init(withUser user: User?) {
        self.auth = AuthenticationViewModel(withUser: user)
    }
    
    init(withDevUser user: DevUser) {
        self.auth = AuthenticationViewModel(withDevUser: user)
    }
    
}
