//
//  ProfileView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/21/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            headerComponents
            
            VStack(spacing: 0) {
                
                Button(action: {}) {
                    HStack {
                        
                        Text("Report an issue")
                            .font(.custom("PublicSans-Bold", size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "exclamationmark.bubble")
                            .font(.system(size: 20, weight: .bold))
                        
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.theme.purple)
                    }
                }
                  
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

extension ProfileView {
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("Settings")
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.lightPurple.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
