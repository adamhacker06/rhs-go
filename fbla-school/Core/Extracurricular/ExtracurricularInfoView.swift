//
//  ExtracurricularInfoView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 3/2/22.
//

import SwiftUI
import MessageUI

struct ExtracurricularInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showMailView: Bool = false
    @State private var emailResult: Result<MFMailComposeResult, Error>? = nil
    
    let extracurricular: ExtracurricularModel
    
    var body: some View {
        
        VStack {
         
            headerComponents
            
            ScrollView(.vertical, showsIndicators: false) {
                description
                    .foregroundColor(.black)
                
                HStack {
                    emailButton
                    twitterButton
                    instagramButton
                }
            }
        }
        .sheet(isPresented: $showMailView) {
            SendMailView(result: $emailResult, components: createEmailComponents())
        }
    }
}

extension ExtracurricularInfoView {
    
    func createEmailComponents() -> EmailComponents {
        
        return EmailComponents(
            
            subject: "Interested in \(extracurricular.title)",
            recipients: [extracurricular.email],
            receipiantType: .to,
            bodyContent: "Hello! I am interested in \(extracurricular.title). I would love to learn more about it. Could you send me some information about the club? Thanks"
            
        )
        
    }

    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text(extracurricular.title)
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.rubyRed.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
    
    private var description: Text {
        if let description = extracurricular.description {
            return Text(description)
        } else {
            return Text("No description provided. Contact the advisor for more information!")
        }
    }
    
    private var emailButton: some View {
        
        Button(action: {
            showMailView = true
        }) {
            Text("send email")
        }
        
    }
    
    private var twitterButton: some View {
        
        if let twitterHandle = extracurricular.twitterHandle {
            return AnyView (
            
                Button(action: {
                    
                    TwitterManager.openTwitterProfile(handle: twitterHandle)
                    
                }) {
                    Text("Open in twitter")
                }
            
            )
        } else {
            return AnyView (
                
                EmptyView()
                
            )
        }
    }
    
    private var instagramButton: some View {
        
        if let instagramHandle = extracurricular.igHandle {
            return AnyView (
            
                Button(action: {
                    
                    InstagramManager.openInstagramProfile(handle: instagramHandle)
                    
                }) {
                    Text("Open in instagram")
                }
            
            )
        } else {
            return AnyView (
                
                EmptyView()
                
            )
        }
        
    }
}

//struct ExtracurricularInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExtracurricularInfoView()
//    }
//}
