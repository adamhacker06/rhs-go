//
//  HomeMessageButtonView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/13/22.
//

import SwiftUI

struct HomeMessageButtonView: View {
    
    @State private var showMessaging: Bool = false
    
    var body: some View {
        
        ZStack {
            
            NavigationLink("", isActive: $showMessaging) {
                MessagingView()
            }
            
            Circle()
                .strokeBorder(Color.theme.lightPurple, lineWidth: 2)
                .background(Circle().foregroundColor(.white))
                .frame(maxWidth: 50, maxHeight: 50)
                .overlay {
                    Image(systemName: "paperplane")
                        .foregroundColor(Color.theme.lapiz)
                }
                .onTapGesture {
                    showMessaging = true
                }
        }
    }
}

struct HomeMessageButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMessageButtonView()
    }
}
