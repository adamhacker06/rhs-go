//
//  HomeView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/22/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authObj: AuthenticationViewModel
    
    var body: some View {
        VStack {
            
            Text(authObj.user!.profileInfo.firstName!)
            
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
        HomeView()
    }
}
