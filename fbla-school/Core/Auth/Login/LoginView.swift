//
//  LoginView.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

typealias Screen = UIScreen

struct LoginView: View {
    
    @EnvironmentObject var data: DataManager
//    @EnvironmentObject var auth: AuthManager
    
    var body: some View {
        ZStack {
            Color.theme.lightBlue.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                logo
                    
                    VStack(spacing: 20) {
                        
//                        googleSignInButton
                        
                        emailSignInButton
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: Screen.main.bounds.height * 0.25, alignment: .center)
                    .padding(.vertical, getSafeArea().bottom > 0 ? getSafeArea().bottom : 20)
                    .padding(.top, getSafeArea().bottom == 0 ? 10 : 0)
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
    
    private var emailSignInButton: some View {
        Button(action: {
            
//            auth.signInWithEmailAndPassword(email: "adamhack2006@gmail.com", password: "Brookeadam06") { user in
//                data.user = user
//            }
            
        }, label: {
            
            HStack(spacing: 0) {
                
                Image(systemName: "envelope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 30)
                    
                
                Text("Sign in with Email")
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: .infinity)
                
            }
           
        })
        .buttonStyle(GeneralButtonStyle())
    }
    
    /*private var googleSignInButton: some View {
        Button(action: { auth.signInWithGoogle { user in
            print(user)
            data.user = user
//            print(data.user?.googleUser)
            
        } }) {
            
            HStack(spacing: 0) {
                Image("google-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 30)
                
                Text("Sign in with Google")
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(GeneralButtonStyle())
        //        .overlay(
        //
        //            Text("Sign in with your school account!")
        //                .font(.subheadline)
        //                .minimumScaleFactor(0.5)
        //                .lineLimit(1)
        //                .foregroundColor(Color(.placeholderText))
        //                .frame(maxWidth: Screen.main.bounds.width * 0.7)
        //                .multilineTextAlignment(.center)
        //                .offset(y: 50)
        //
        //        )
    }*/
    
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
            ContentView()
                .environmentObject(DataManager())
//                .environmentObject(AuthManager())
            
            ContentView()
                .environmentObject(DataManager()).previewDevice("iPod touch (7th generation)")
//                .environmentObject(AuthManager())
            
            ContentView()
                .environmentObject(DataManager()).previewDevice("iPhone SE (2nd generation)")
//                .environmentObject(AuthManager())
        }
    }
}
