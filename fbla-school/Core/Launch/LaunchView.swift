//
//  LaunchView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 10/3/21.
//

import SwiftUI

struct LaunchView: View {
    
    @Binding var finishedLoading: Bool
    
    @State private var loadingText: [String] = "Loading your info...".map { String($0) }
    @State private var currentCharIndex: Int = 0
    @State private var finishedRotations: Int = 0
    
    let charTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.theme.lapiz.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("rhs_blue")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                
            }
            .frame(maxWidth: .infinity)
            .overlay(
                HStack(spacing: 0) {
                    ForEach(loadingText.indices, id: \.self) { charIndex in
                        Text(loadingText[charIndex])
                            .foregroundColor(.white)
                            .font(.custom("PublicSans-Bold", size: 32))
                            .offset(y: currentCharIndex == charIndex ? -5 : 0)
                            
                    }
                }
                    .offset(y: 80)
            )
        }
        .onReceive(charTimer) { _ in
            withAnimation {
                
                if finishedRotations == 3 {
                    withAnimation { finishedLoading = true }
                }
                
                if currentCharIndex > loadingText.count - 1 {
                    
                    currentCharIndex = 0
                    finishedRotations += 1
                    
                } else {
                    
                    currentCharIndex += 1
                    
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(finishedLoading: .constant(false))
    }
}
