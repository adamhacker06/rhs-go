//
//  HTMLTestView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/18/22.
//

import SwiftUI
import GoogleSignIn

struct HTMLTestView: View {
    
//    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var data: DataManager
    
    var body: some View {
        VStack {
            Text("Hello!")
            
//            Button("Test") {
//                CalendarAPIManager.sendPublicGETRequest() { response in
//                    print(response)
//                }
//            }
            
            Button("Sign Out") {
//                auth.signOut()
            }
        }
    }
}

struct HTMLTestView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLTestView()
    }
}

enum CalendarScopeResponse {
    case accepted
    case declined
}

extension HTMLTestView {
    
    func getWindow() -> UIViewController {
        let scenes = UIApplication.shared.connectedScenes
        guard let windowScene = scenes.first as? UIWindowScene else {
            return .init()
        }
        
        return windowScene.windows.first?.rootViewController ?? .init()
        
    }
    
}

/*
 
 guard let user = data.user?.googleUser else {
     print("uhh ohh!!")
     return
 }
 
 user.authentication.do { (authentication, error) in
     guard error == nil else { return }
     guard let authentication = authentication else { return }
     
     let calendarScope = "https://www.googleapis.com/auth/calendar.events.readonly"
     print("declared scope")
     
     if user.grantedScopes == nil || !user.grantedScopes!.contains("https://www.googleapis.com/auth/calendar.events.readonly") {
         
         CalendarAPIManager.requestAdditionalScopes(scopes: [calendarScope], presenting: getWindow()) { (response, user) in
             
             data.user?.googleUser = user
             
             print("got a response of some sort")
             switch response {
             case .accepted:
                 print("ACCEPPTED!")
                 CalendarAPIManager.sendGETRequest(token: authentication.accessToken) { response in
                     
                     print(response)
                 }
                 
             case .declined:
                 print("Uh oh declined!")
             }
         }
         
     } else {
         CalendarAPIManager.sendGETRequest(token: authentication.accessToken) { response in
             
             print(response)
             
         }
     }
 }
 
 */
