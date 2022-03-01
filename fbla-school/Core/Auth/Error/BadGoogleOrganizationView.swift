//
//  BadGoogleOrganizationView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI

struct BadGoogleOrganizationView: View {
    
//    @EnvironmentObject var authObj: AuthManager
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {

                Image("robot-error")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 50)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Text("Uh-oh!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxHeight: .infinity)
                
                VStack(spacing: 0) {
                    Spacer()
                    Text("Please sign in using your official VUSD school account.")
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: Screen.main.bounds.width * 0.9)
                    Spacer()
                    Button("Sign Out") {
//                        authObj.signOut()
                    }
                    .buttonStyle(GeneralButtonStyle())
                    Spacer()
                }
                .foregroundColor(.white)
                .frame(maxHeight: .infinity)
                .background(
                
                    Color.theme.lightBlue
                        .cornerRadius(25)
                        .shadow(color: Color(.placeholderText), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                )
            }
            .padding(.vertical)
        }
    }
}

struct BadGoogleOrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        
        EmptyView()
//        BadGoogleOrganizationView().environmentObject(AuthManager())
//        BadGoogleOrganizationView().environmentObject(AuthManager()).previewDevice("iPod touch (7th generation)")
    }
}
