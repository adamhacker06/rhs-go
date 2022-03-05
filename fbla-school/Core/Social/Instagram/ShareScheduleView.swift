//
//  ShareToInstagramView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/20/22.
//

import SwiftUI

struct ShareScheduleView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var origin: CGPoint = .zero
    @State private var size: CGSize = CGSize()

    var schedule: some View {
        SharedScheduleView(schedule: data.scheduleDataManager.schedule)
    }
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack(spacing: 0) {
                
                headerComponents
                
                ScrollView(.vertical, showsIndicators: false) {
                    schedule
                        .padding(.top)
                        .background(Color.theme.lapiz)
                        .padding()
                }
                
                if !InstagramManager.canOpenInstagram {
                    
                    Text("Your device can not open Instagram. Please ensure the Instagram app is downloaded on your phone.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            Color.theme.lightBlue.ignoresSafeArea()
                        }
                    
                    
                }
                
                footerComponents
                
                
            }
        }
    }
}

extension ShareScheduleView {
    
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("Sharing")
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.lapiz.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }

    
    private var footerComponents: some View {
        
        HStack {
            Button(action: {
                RHS_Go.actionSheet(image: schedule.snapshot())
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .overlay {
                        Text("Other")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 40)
                
            }
            
            Spacer(minLength: 30)
            
            Button(action: {
                
                DispatchQueue.main.async {
                    InstagramManager.shareToInstagram(image: schedule.snapshot())
                }
                
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .overlay {
                        HStack(spacing: 5) {
                            
                            Image("instagram")
                                .font(.title3)
                            
                            Text("Share")
                                .fontWeight(.bold)
                            
                        }
                        .foregroundColor(Color.theme.lapiz)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 40)
                
            }
            .disabled(!InstagramManager.canOpenInstagram)
            .opacity(!InstagramManager.canOpenInstagram ? 0.7 : 1)
            
        }
        .foregroundColor(Color.theme.white)
        .padding()
        .background {
            Color.theme.lapiz.ignoresSafeArea()
                .shadow(radius: 5)
        }
        
    }
    
}

struct ShareToInstagramView_Previews: PreviewProvider {
    static var previews: some View {
        ShareScheduleView()
    }
}
