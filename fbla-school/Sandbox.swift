//
//  Sandbox.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 11/20/21.
//

import SwiftUI
import FirebaseStorage

struct Sandbox: View {
    
    @EnvironmentObject var auth: AuthManager
    
    var vm = SandboxViewModel()
    
    @State private var imageURL: URL?
    
    var body: some View {
        
        VStack {
            if let imageURL = imageURL {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: imageURL)
                }
            } else {
                Text("Image loading")
            }
            
            Button("Sign Out") {
                auth.signOut()
            }
            Button("test") {
                vm.fetchImage(fileRef: "test.png") { url in
                    self.imageURL = url
                    print("FINISHED")
                }
            }
        }
        .onAppear {
            print("STRATING")
            
            vm.fetchImage(fileRef: "test.png") { url in
                self.imageURL = url
                print("FINISHED")
            }
        }
    }
}

extension Sandbox {
    
}

struct Sandbox_Previews: PreviewProvider {
    static var previews: some View {
        Sandbox()
    }
}
