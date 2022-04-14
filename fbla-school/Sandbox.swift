//
//  Sandbox.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 11/20/21.
//

import SwiftUI
import FirebaseStorage
import MessageUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Sandbox: View {
    
    //    @EnvironmentObject var auth: AuthManager
    
    
    var vm = SandboxViewModel()
    
    @State private var imageURL: URL?
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        
        //        VStack {
        //            if let imageURL = imageURL {
        //                if #available(iOS 15.0, *) {
        //                    AsyncImage(url: imageURL)
        //                }
        //            } else {
        //                Text("Image loading")
        //            }
        //
        //            Button("Sign Out") {
        //                auth.signOut()
        //            }
        //            Button("test") {
        //                vm.fetchImage(fileRef: "test.png") { url in
        //                    self.imageURL = url
        //                    print("FINISHED")
        //                }
        //            }
        //        }
        //        .onAppear {
        //            print("STRATING")
        //
        //            vm.fetchImage(fileRef: "test.png") { url in
        //                self.imageURL = url
        //                print("FINISHED")
        //            }
        //        }
        
        //        Button("Hello!") {
        //
        //            if let jsonData = getSubjectJSONData() {
        //                parseSubjectsJSON(data: jsonData)
        //            } else {
        //                print("Unable to get data.")
        //            }
        //
        //        }
        //        .foregroundColor(.blue)
        
        //        Button(action: {
        //            self.isShowingMailView.toggle()
        //        }) {
        //            Text("Tap Me")
        //        }
        //        .disabled(!MFMailComposeViewController.canSendMail())
        //        .sheet(isPresented: $isShowingMailView) {
        //            SendMailView(result: $result)
        //        }
        
        
        Text("")
    }
}

struct Sandbox_Previews: PreviewProvider {
    static var previews: some View {
        Sandbox()
    }
}
