//
//  ContentView.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI

struct ContentView: View {
    
    // Grabs the auth object from the environment
    @EnvironmentObject var authObj: AuthenticationViewModel
    
    var body: some View {
        
        ZStack {
            
            // Switches between the SignedIn state
            switch authObj.state {
            
            case .signedIn:
                
                if !authObj.user!.profileInfo.emailAddress.contains("@vusd.us") && !authObj.user!.profileInfo.emailAddress.contains("@vusd.org") {
                    
                    BadGoogleOrganizationView()
                    
                } else {
                    HomeView()
                        .environmentObject(authObj.user!)
                }
                
                
            
            case .signedOut:
                LoginView()
                    .transition(AnyTransition.opacity)
                    .zIndex(1.0)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthenticationViewModel())
    }
}
