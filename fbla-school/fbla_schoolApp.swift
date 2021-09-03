//
//  fbla_schoolApp.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main struct fbla_schoolApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var data = DataManager()
    @StateObject var auth = AuthManager()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(data)
//                .environmentObject(auth)
//                .preferredColorScheme(.light)
            
            NavigationView {
                GiganteaFeed()
                    .navigationTitle("")
                    .navigationBarHidden(true)
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            FirebaseApp.configure()
            
            return true
        }
    }
}


