//
//  fbla_schoolApp.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI
import Firebase

@main struct rhs_goApp: App {
    
    // Creates the app delegate (see comment above AppDelegate class declaration)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Initiates a new DataManager class. This is where most of the data used during runtime is stored.
    @StateObject var data = DataManager()
    
    // A @State-property wrapped variable that is used to track whether the app has finished loading data from Firebase.
    @State private var finishedLoading: Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            // ZStack containing the ContentView below and the LaunchView above. The LaunchView only shows if the app has 'false' for the finishedLoading variable
            ZStack {
                ContentView()
                    .environmentObject(data)
                    .preferredColorScheme(.light)
                
                if !finishedLoading {
                    LaunchView(finishedLoading: $finishedLoading)
                        .zIndex(1)
                        .transition(.opacity)
                        .environmentObject(data)
                }
            }
        }
    }
    
    // The AppDelegate class which, in this case, is used to configure Firebase during runtime. The app has to configure Firebase within the AppDelegate to ensure this happens before loading any other aspects of the app.
    class AppDelegate: NSObject, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            // The func within Firebase which configures Firebase for runtime
            FirebaseApp.configure()
            
            return true
        }
        
    }
}


