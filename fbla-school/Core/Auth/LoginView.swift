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
            Color.secondary.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                Image("rhs_blue")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 150)
                    .padding()
                    .background(
                        
                        Color(.systemBlue)
                            .cornerRadius(20)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                    )
                
                Spacer()
                
                Button("Sign up with Google") {
                    authObj.signIn()
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
            .frame(maxWidth: .infinity)
            .background(Color(.systemTeal))
            .cornerRadius(12)
            .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environmentObject(AuthenticationViewModel())
        }
    }
}
