//
//  fbla_schoolApp.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct fbla_schoolApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(.light)
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            FirebaseApp.configure()
            
            return true
        }
    }
}


