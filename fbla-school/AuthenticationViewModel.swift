//
//  AuthenticationViewModel.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/21/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

class AuthenticationViewModel: NSObject, ObservableObject {
    
    let signInConfig = GIDConfiguration.init(clientID: (FirebaseApp.app()?.options.clientID!)!)
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    func signIn() {
        if GIDSignIn.sharedInstance.currentUser == nil {
            
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: (UIApplication.shared.windows.first?.rootViewController)!) { [weak self] user, error in
                if error == nil {
                    self?.firebaseAuthentication(withUser: user!)
                } else {
                    print(error.debugDescription)
                }
            }
        }
    }
    
    private func firebaseAuthentication(withUser user: GIDGoogleUser) {
        let authentication = user.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .signedIn
            }
        }
        
    }
    
    // 5
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            state = .signedOut
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
    }
    
}
