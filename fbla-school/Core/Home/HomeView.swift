//
//  HomeView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/22/21.
//

import SwiftUI
import GoogleSignIn

struct HomeView: View {
    
    @EnvironmentObject var authObj: AuthenticationViewModel
    
    var body: some View {
        VStack {
            
            Text("Welcome " + authObj.user!.profileInfo.firstName!)
                .font(.title)
                .foregroundColor(.black)
            
            Button("Sign out") {
                authObj.signOut()
            }
            
            Button("Share to instagram") {
                shareToInstagram()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AuthenticationViewModel(withDevUser: DevUser(email: "test@test.com ", firstName: "Adam", lastName: "Hacker")))
        
    }
}
