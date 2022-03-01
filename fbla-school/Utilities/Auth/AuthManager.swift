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

/*extension AuthManager {
    func getLoginViewWindow() -> UIViewController {
        let scenes = UIApplication.shared.connectedScenes
        guard let windowScene = scenes.first as? UIWindowScene else {
            return .init()
        }
        
        return windowScene.windows.first?.rootViewController ?? .init()
        
    }
}

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
    func signInWithGoogle(completion: @escaping (User) -> Void ) {
        
        print("Signing in..")
        
        // Checks if there is a user logged in
        if GIDSignIn.sharedInstance.currentUser == nil {
            
            // If no user is logged in, Google Sign-In starts the sign-in flow
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: getLoginViewWindow()) { [self] user, error in
                if error == nil {
                    
                    guard
                        let authentication = user?.authentication,
                        let idToken = authentication.idToken
                        
                    else {
                        return
                    }
                    
                    // If there is no error, sign the user in using Firebase
                    self.firebaseAuth(withGoogleUser: user!) { firebaseUser in
                        completion(User(user: firebaseUser))
                    }
                    
                } else {
                    
                    // If there is an error, print the error out to the console
                    print(error.debugDescription)
                }
            }
        }
    }
    func signInWithEmailAndPassword(email: String, password: String, completion: @escaping (User) -> Void) {
        firebaseAuth(withEmail: email, password: password) { user in
            completion(User(user: user))
        }
    }
    
    private func firebaseAuth(withEmail email: String, password: String, completion: @escaping (FirebaseAuth.User) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            guard let authResult = authResult else {
                guard let error = error else {
                    print("Unknown error occured when signing into firebase with email")
                    return
                }
                        
                print(error.localizedDescription)
                return
            }
        
            print(authResult.user)
            completion(authResult.user)
            withAnimation { self.state = .signedIn }
        }
    }
    
    // Takes in a user and signs them in with Firebase
    private func firebaseAuth(withGoogleUser user: GIDGoogleUser, completion: @escaping (FirebaseAuth.User) -> ()) {
    
        // Stores the authentication information for the provided user
        let authentication = user.authentication
        
        // Creates a credential using the authentication information
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
        
        // Signs the user in with Firebase using the credential
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            guard let authResult = authResult else {
                if let error = error {
                    print("error: \(error.localizedDescription)")
                }
                
                return
            }
            
            // User is logged in if there is no error automatically
            completion(authResult.user)
            
            // Change the sign-in state to signedIn
            withAnimation { self.state = .signedIn }
    
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
}*/

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
