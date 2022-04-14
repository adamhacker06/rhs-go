//
//  ContentView.swift
//  fbla-school
//
//  Created by Adam Hacker on 8/19/21.
//

import SwiftUI

/// A `View` that contains all of the apps UI content (excluding the  `LaunchView`). See `rhs_goApp` for visibility conditions.
struct ContentView: View {
    
    // Grabs the auth object from the environment
    @EnvironmentObject var data: DataManager
    
    @State private var navBarHidden: Bool = true
    
    var body: some View {
        
//        ScheduleSandbox()
        
        ZStack {

            NavigationView {
                HomeView()
                    .navigationViewStyle(.stack)
                    .navigationTitle("")
                    .navigationBarHidden(true)

            }
            .navigationViewStyle(.stack)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataManager())
    }
}
