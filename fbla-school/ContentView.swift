//
//  ContentView.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI

struct ContentView: View {
    
    // Grabs the auth object from the environment
    @EnvironmentObject var data: DataManager
    @EnvironmentObject var auth: AuthManager
    
    var body: some View {
        
        ZStack {
            
            // Switches between the SignedIn state
            switch auth.state {
            
            case .signedIn:
                
                if !data.user!.profileInfo.emailAddress.contains("@vusd.us") && !data.user!.profileInfo.emailAddress.contains("@vusd.org") {
                    
                    BadGoogleOrganizationView()
                    
                } else {
                    NavigationView {
                        HomeView()
                            .environmentObject(data.user!)
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    }
                }
                
            case .signedOut:
                LoginView()
                    .transition(AnyTransition.opacity)
                    .zIndex(1.0)
            
            }
        }
        .onAppear {
            data.listenForUser { (signInState) in
                auth.state = signInState
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthManager())
            .environmentObject(DataManager())
    }
}
