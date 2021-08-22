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
                Spacer()
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
                
                Spacer()
                
                
                Button(action: {authObj.signIn()}) {
        
                    Label(
                        title: { Text("Sign In With Google").bold() },
                        icon: { Image("google-logo").resizable().aspectRatio(contentMode: .fit).frame(height: 25)
                            .padding(.trailing)
                        }
                    )
                    
                }
                .buttonStyle(AuthenticationButtonStyle())
                
                Spacer()
            }
        }
    }
}

struct AuthenticationButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: Screen.main.bounds.width * 0.75)
            .background(Color.theme.lapiz)
            .cornerRadius(13)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(AuthenticationViewModel())
        }
    }
}
