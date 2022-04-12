//
//  fbla_schoolApp.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI
import Firebase

/// A struct used as the root level of the app. When the app starts, this is what is first shown.
///
/// For RHS Go, a `ZStack` is the main view. On top lies the `LaunchView`, yet it only shows when `finishedLoading` is set to false. Otherwise, the lower view is revealed containing the `ContentView`.
@main struct rhs_goApp: App {
    
    // Creates the app delegate (see AppDelegate)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Initiates a new DataManager class. This is where most of the data used during runtime is stored.
    @StateObject var data = DataManager()
    
    /// Stores a `Bool` used to track whether the app has finished loading data from Firebase.
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
    
    /// A class that manages additional functionality during the app's launch.
    ///
    /// Within RHS Go, the `AppDelegate` class is implemented  to configure Firebase during runtime. The app has to configure Firebase at this scope to ensure this happens before loading any other aspects of the app.
    class AppDelegate: NSObject, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            // The func within Firebase which configures Firebase for runtime
            FirebaseApp.configure()
            
            return true
        }
        
    }
}


