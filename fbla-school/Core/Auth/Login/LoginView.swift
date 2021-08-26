//
//  LoginView.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI

typealias Screen = UIScreen

struct LoginView: View {
    
    @EnvironmentObject var authObj: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            Color.theme.lightBlue.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                logo
                
                VStack(spacing: 0) {
                    googleSignInButton
                   
                }
                .frame(maxWidth: .infinity, maxHeight: Screen.main.bounds.height * 0.25, alignment: .center)
                .padding(.bottom, getSafeArea().bottom)
                .background(
                    signInBackground
                )
                .cornerRadius(25, corners: [.topLeft, .topRight])
                .shadow(color: .white.opacity(0.3), radius: 20)
                .offset(CGSize(width: 0, height: getSafeArea().bottom))
                
            }
        }
    }
}

extension LoginView {
    private var logo: some View {
        VStack(spacing: 0) {
            Image("rhs_blue")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 150)
                .padding()
                .background(
                    
                    Color.white
                        .cornerRadius(20)
                        .shadow(radius: 10)
                    
                )
        }
        .frame(maxWidth: .infinity, maxHeight: Screen.main.bounds.height * 0.75, alignment: .center)
    }
    
    private var googleSignInButton: some View {
        Button(action: { authObj.signIn() }) {

            Label (
                title: { Text("Sign In With Google").bold().lineLimit(1).minimumScaleFactor(0.5) },
                icon: { Image("google-logo").resizable().aspectRatio(contentMode: .fit).frame(maxHeight: 30).clipped()
                    
                }
            )
            
        }
        .buttonStyle(GeneralButtonStylr())
        .overlay(
        
            Text("Tip: sign in with your school account!")
                .font(.subheadline)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(Color(.placeholderText))
                .frame(maxWidth: Screen.main.bounds.width * 0.7)
                .multilineTextAlignment(.center)
                .offset(y: 50)
        
        )
    }
    
    private var signInBackground: some View {
        ZStack {
            Color.white
            CustomDivider(color: .theme.lapiz, thickness: 3)
                .frame(maxWidth: Screen.main.bounds.width * 0.8, maxHeight: .infinity, alignment: .top)
                .padding(.top, 10)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(AuthenticationViewModel())
            ContentView().environmentObject(AuthenticationViewModel()).previewDevice("iPod touch (7th generation)")
            ContentView().environmentObject(AuthenticationViewModel()).previewDevice("iPhone SE (2nd generation)")
        }
    }
}
