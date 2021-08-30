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
    @EnvironmentObject var auth: AuthenticationViewModel
    
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthenticationViewModel())
    }
}
