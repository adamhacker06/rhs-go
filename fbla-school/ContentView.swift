//
//  ContentView.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authObj: AuthenticationViewModel
    
    var body: some View {
        
        switch authObj.state {
        case .signedIn:
            Button("Sign out") {
                authObj.signOut()
            }
        
        case .signedOut:
            LoginView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
