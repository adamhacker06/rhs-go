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
    
    @State private var navBarHidden: Bool = true
    
    var body: some View {
        
        ZStack {
            
            // Switches between the SignedIn state
            switch auth.state {
                
            case .signedIn:
                
                if !data.user!.profileInfo.emailAddress.contains("@vusd.us") && !data.user!.profileInfo.emailAddress.contains("@vusd.org") {
                    
                    //BadGoogleOrganizationView()
                    
                    HomeView()
                        .navigationViewStyle(.stack)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                        .environmentObject(data.user!)
                    
                } else {
                    NavigationView {
                        HomeView()
                            .navigationViewStyle(.stack)
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            .environmentObject(data.user!)
                        
//                        HTMLTestView()
                    }
                    
//                    Sandbox()
                }
                
            case .signedOut:
//                Sandbox()
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
