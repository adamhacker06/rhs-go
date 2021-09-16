//
//  fbla_schoolApp.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI
import Firebase
import FirebaseDatabase
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
                AllFoodView()
                    .environmentObject(data)
                    .navigationTitle("Foods")
                    .preferredColorScheme(.light)
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            FirebaseApp.configure()
            Database.database().isPersistenceEnabled = true
            
            return true
        }
    }
}


