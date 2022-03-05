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
        
        VStack(spacing: 0) {
         
            headerComponents
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    
                    advisor
                    
                    description
                        .foregroundColor(.black)
                        .font(.custom("PublicSans-Regular", size: 18))
                    
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .background(Color.white.ignoresSafeArea())
            .overlay(
                VStack {
                    
                    HStack {
                        twitterButton
                        instagramButton
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    emailButton
                }
                .padding()
                
                , alignment: .bottom
            )
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
    
    private var advisor: some View {
        
        VStack(alignment: .leading) {
            
            Text("Advisor")
                .font(.custom("PublicSans-SemiBold", size: 18))
            
            HStack {
                Text(extracurricular.administrator)
                    .font(.custom("PublicSans-Regular", size: 16))
                
                Text(extracurricular.email)
                    .font(.custom("PublicSans-Thin", size: 14))
            }
            
        }
        .foregroundColor(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.theme.rubyRed.cornerRadius(10))
        
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
            HStack {
                Text("Send an Email")
                    .font(.custom("PublicSans-SemiBold", size: 18))
                
                Image(systemName: "paperplane")
                    .font(.system(size: 18))
            }
            .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color.theme.radicalRed)
        .cornerRadius(10)
    }
    
    private var twitterButton: some View {
        
        if let twitterHandle = extracurricular.twitterHandle {
            return AnyView (
            
                Button(action: {
                    
                    TwitterManager.openTwitterProfile(handle: twitterHandle)
                    
                }) {
                    HStack {
                        Image("twitterFill")
                            .font(.title)
                            .foregroundColor(Color.init(hex: 0x1DA1F2))
                        
                        Text("\(extracurricular.title) on Twitter")
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.theme.rubyRed.cornerRadius(10))
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
                    
                    HStack {
                        Image("instagram")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Text("\(extracurricular.title) on Instagram")
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.theme.rubyRed.cornerRadius(10))

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
