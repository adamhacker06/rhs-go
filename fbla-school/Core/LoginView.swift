//
//  LoginView.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI

typealias Screen = UIScreen

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Image("rhs_blue")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button("Sign in with Google") {
                viewModel.signIn()
            }
            .buttonStyle(AuthenticationButtonStyle())
        }
        
    }
}

struct AuthenticationButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(.systemIndigo))
      .cornerRadius(12)
      .padding()
  }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
