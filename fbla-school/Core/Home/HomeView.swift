//
//  HomeView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/22/21.
//

import SwiftUI
//import GoogleSignIn

extension HomeView {
    private var headerComponents: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Welcome Back,")
                    Text(data.user!.profileInfo.firstName!)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("PublicSans-Bold", size: 24))
                
                Circle()
                    .strokeBorder(Color.theme.lightPurple, lineWidth: 2)
                    .background(Circle().foregroundColor(.white))
                    .frame(maxWidth: 50, maxHeight: 50)

            }
            
            Text("Next class: Foundations of Business")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
        }
        .padding(.top, 20)
        .padding([.bottom, .horizontal], 20)
        .foregroundColor(.white)
    }
}

struct HomeView: View {
    
    @EnvironmentObject var data: DataManager
    @EnvironmentObject var auth: AuthManager
    
    @State private var showEditSchedule: Bool = false
    
    var body: some View {
        ZStack {
            
            NavigationLink(
                destination:
                    EditScheduleView()
                    .navigationTitle("")
                    .navigationBarHidden(true)
                ,
                isActive: $showEditSchedule,
                label: {
                    Text("")
                        .hidden()
                })
            
            Color.theme.purple.ignoresSafeArea()
            
            VStack {
                
                headerComponents
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        TodaysClassesView(showEditSchedule: $showEditSchedule)

                        Button("Sign out") {
                            auth.signOut()
                        }
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white
                                .cornerRadius(30, corners: [.topLeft, .topRight])
                                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: -15)
                                .ignoresSafeArea()
                )
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            HomeView()
                .environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")))
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
        
        HomeView().environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")))
            .previewDevice("iPod touch (7th generation)")

    }
}
