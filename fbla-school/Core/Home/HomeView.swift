//
//  HomeView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/22/21.
//

import SwiftUI
//import GoogleSignIn

extension HomeView {
//    private var profilePicture: some View {
//        if let googleUser = data.user!.googleUser {
//
//            if let profile = googleUser.profile {
//
//                if let profileURL = profile.imageURL(withDimension: 50) {
//                    return AsyncImage(url: profileURL)
//                }
//            }
//        }
//
//
//    }
    
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
//                    .overlay {
//
//                        profilePicture
//
//                    }
                
            }
            
            Text("Next class: Foundations of Business")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(.white)
    }
}

struct HomeScrollTopOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct HomeView: View {
    
    @EnvironmentObject var data: DataManager
    @EnvironmentObject var auth: AuthManager
    
    @State private var showEditSchedule: Bool = false
    @State private var showAllFood: Bool = false
    
    @State private var foods: [Food] = []
    
    @State private var topOffset: CGFloat = 0
    
    @State private var showNavbar: Bool = false
    
    @State private var showGigante: Bool = false
    
    var body: some View {
        ZStack {
            
            NavigationLink("", isActive: $showGigante) {
                GiganteaFeed()
            }
            
            Color.theme.purple.ignoresSafeArea()
            
            VStack {
                
                headerComponents
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Group {
                            TodaysClassesView(showEditSchedule: $showEditSchedule)
                                .padding(.horizontal, 20)
                            
                            TodaysFoodView(foods: $data.foodDataManager.foods)
                            
                            TodaysCurrentCalendarView(calendar: $data.calendarDataManager.calendar)
                                .padding(.horizontal, 20)
                            
                            LatestArticleView(gigantea: $data.giganteaDataManager.gigantea)
                            
                            Button("Print schedule") {
                                print(data.scheduleDataManager.schedule)
                            }
 
                            Button("Sign out") {
                                auth.signOut()
                            }
                        }
                        .padding(.top, 20)
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white
                                .cornerRadius(20, corners: [.topLeft, .topRight])
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
                .environmentObject(AuthManager())
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}
