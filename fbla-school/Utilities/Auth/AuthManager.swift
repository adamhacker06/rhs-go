//
//  AuthenticationViewModel.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/21/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthManager: ObservableObject {
    
    // Stores and creates the Google Sign-In configuration value to be used throughout the Google Sign-In process
    let signInConfig = GIDConfiguration.init(clientID: (FirebaseApp.app()?.options.clientID!)!)
    
    // A custom enum for defining sign-in state
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    // A published var for tracking sign-in state, conforms to the previously declared SignInState enum
    @Published var state: SignInState = .signedOut
    
    // Handles the sign in process
    func signIn(completion: @escaping (User) -> Void) {
        
        // Checks if there is a user logged in
        if GIDSignIn.sharedInstance.currentUser == nil {
            
            // If no user is longed in, Google Sign-In starts the sign-in flow
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: (UIApplication.shared.windows.first?.rootViewController)!) { [weak self] user, error in
                if error == nil {
                    
                    // If there is no error, sign the user in using Firebase
                    self?.firebaseAuth(withUser: user!)
                    
                    completion(User(withUser: user!))
                    
                } else {
                    
                    // If there is an error, print the error out to the console
                    print(error.debugDescription)
                }
            }
        }
    }
    
    // Takes in a user and signs them in with Firebase
    private func firebaseAuth(withUser user: GIDGoogleUser) {
    
        // Stores the authentication information for the provided user
        let authentication = user.authentication
        
        // Creates a credential using the authentication information
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
        
        // Signs the user in with Firebase using the credential
        Auth.auth().signIn(with: credential) { (_, error) in
            if let error = error {
                
                // If there is an error, print the error out to the console
                print(error.localizedDescription)
            } else {
                
                // User is logged in if there is no error automatically
                
                // Change the sign-in state to signedIn
                withAnimation { self.state = .signedIn }
            }
        }
    }
    
    // Signs out the user
    func signOut() {
        
        // Signs the user out of their Google account
        GIDSignIn.sharedInstance.signOut()
        
        // Signs the user out of Firebase
        do {
            
            // Signs the user out and changes the state to signedOut
            try Auth.auth().signOut()
            state = .signedOut
            
        } catch let signOutError as NSError {
            
            // If there is an error, prints the error out to the console
            print(signOutError.localizedDescription)
        }
    }
    
    
}


struct GeneralButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(15)
            .frame(maxWidth: Screen.main.bounds.width * 0.75)
            .background(Color.theme.lapiz)
            .cornerRadius(13)
    }
}
