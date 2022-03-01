//
//  HomeView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/22/21.
//

import SwiftUI
//import GoogleSignIn

extension HomeView {
    
    private func instagramViewerHandler() {
        let instagramURL = URL(string: "instagram://user?username=rhsrangers")!
        let application = UIApplication.shared
        
        if application.canOpenURL(instagramURL) {
            application.open(instagramURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://instagram.com/rhsrangers")!
            application.open(webURL)
        }
    }
    
    var headerComponents: some View {
        VStack(spacing: 0) {
            
            if showHeader {
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Text("Welcome Back")
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("PublicSans-Bold", size: 24))
                        
                        Button(action: { showProfile = true } ) {
                            Circle()
                                .strokeBorder(Color.init(hex: 0xf5f5f5), lineWidth: 2)
                                .background(Circle().foregroundColor(.white))
                                .frame(maxWidth: 50, maxHeight: 50)
                                .overlay {
                                    
                                    Image(systemName: "gear")
                                        .foregroundColor(Color.theme.lapiz)
                                        .font(.title)
                                    
                                }
                        }
                    }
                    
                    Text("It's a great day to be a Ranger!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(Color.theme.lapiz.ignoresSafeArea())
                .transition(.move(edge: .top))
            }
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        //                        instagramViewerHandler()
                        
                        //                        let appURL = NSURL(string: "twitter://user?screen_name=RedwoodFBLA_")!
                        //                        let webURL = NSURL(string: "https://twitter.com/RedwoodFBLA_")!
                        //
                        //                        let application = UIApplication.shared
                        //
                        //                        if application.canOpenURL(appURL as URL) {
                        //                            application.open(appURL as URL)
                        //                        } else {
                        //                            application.open(webURL as URL)
                        //                        }
                        
                        let tweetText = "hello!"
                        let tweetURL = "https://www.brainiacsmentoring.com"
                        
                        let shareString = "https://twitter.com/intent/tweet?text=\(tweetText)&url=\(tweetURL)"
                        
                        // encode a space to %20 for example
                        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                        
                        // cast to an url
                        let url = URL(string: escapedShareString)
                        
                        // open in safari
                        UIApplication.shared.open(url!)
                        
                        
                    } ) {
                        HStack {
                            Text("View Instagram")
                                .font(.custom("PublicSans-Medium", size: 16))
                            
                            Image("instagram")
                        }
                        .foregroundColor(Color.theme.lapiz)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                    
                    Rectangle()
                        .frame(width: 2.5, height: 30)
                        .foregroundColor(Color.init(hex: 0xf5f5f5))
                    
                    Button(action: { showMessaging = true } ) {
                        HStack {
                            Text("Send a Message")
                                .font(.custom("PublicSans-Medium", size: 16))
                            
                            Image(systemName: "paperplane")
                        }
                        .foregroundColor(Color.theme.lapiz)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                    .background {
                        NavigationLink("", isActive: $showMessaging) {
                            MessagingView()
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
                Rectangle()
                    .frame(height: 5)
                    .foregroundColor(Color.init(hex: 0xf5f5f5))
            }
            
            .background(Color.white.ignoresSafeArea())
            
        }
        
        .background {
            
            GeometryReader { geo in
                ZStack {
                    NavigationLink("", isActive: $showProfile) {
                        ProfileView()
                    }
                    
                }
                .preference(key: HeaderSizePreferenceKey.self, value: (geo.size))
            }
        }
    }
    
    private var messageButtonComponents: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                HomeMessageButtonView()
                
            }
        }
        .padding()
    }
}

struct HomeView: View {
    
    @EnvironmentObject var data: DataManager
//    @EnvironmentObject var auth: AuthManager
    
    @State private var showEditSchedule: Bool = false
    @State private var showAllFood: Bool = false
    
    @State private var foods: [Food] = []
    
    @State private var topOffsetPoint: CGPoint = .zero
    
    @State private var showProfile: Bool = false
    
    @State private var showMessaging: Bool = false
    
    @State private var scrollOffset: CGFloat = .zero
    
    @State private var headerSize: CGSize = .zero
    
    var tileTypes: [Any] = [TodaysFoodView.self, TodaysCalendarView.self, LatestArticleView.self, TodaysClassesView.self]
    
    var showHeader: Bool {
        switch scrollOffset {
        case ...(-50):
            return false
        default:
            return true
        }
    }
    
    var body: some View {
        ZStack {
            
            //            Color.theme.purple.ignoresSafeArea()
            
            VStack {
                headerComponents
                    .onPreferenceChange(HeaderSizePreferenceKey.self) { headerSize = $0 }
                
                Spacer()
            }
            .zIndex(1)
            
            VStack(spacing: 0) {
                
                ScrollViewOffset {
                    VStack(spacing: 0) {
                        
                        if showHeader {
                            Color.clear
                                .frame(width: headerSize.width, height: headerSize.height)
                                .transition(.move(edge: .top))
                        }
                        
                        ForEach(0..<tileTypes.count) { index in
                            self.buildView(types: tileTypes, index: index)
                        }
                        
                        /*Group {
                            TodaysClassesView(showEditSchedule: $showEditSchedule)
                                .padding(.horizontal, 20)
                            
                            TodaysFoodView(foods: $data.foodDataManager.foods, isUpdating: $data.foodDataManager.isUpdating)
                            
                            TodaysCalendarView(calendarDataManager: $data.calendarDataManager, isUpdating: $data.calendarDataManager.isUpdating)
                                .padding(.horizontal, 20)
                            
                            LatestArticleView(gigantea: $data.giganteaDataManager.gigantea)
                            
                            Button("Sign out") {
                                auth.signOut()
                                data.user = nil
                            }
                            
                        }*/
                        .padding(.top, 20)
                        .background {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(
                                        key: OffsetPreferenceKey.self,
                                        value: proxy.frame(in: .named("frameLayer")).minY // 👈🏻
                                    )
                            }
                        }
                    }
                } onOffsetChange: { offset in
                    scrollOffset = offset
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.ignoresSafeArea())
                
                
            }
            
            
        }
        .animation(Animation.spring(), value: showHeader)
        .animation(Animation.spring(), value: headerSize)
    }
    
    func buildView(types: [Any], index: Int) -> AnyView {
        switch types[index].self {
        case is TodaysClassesView.Type: return AnyView (
            TodaysClassesView(showEditSchedule: $showEditSchedule)
                .padding(.horizontal, 20)
        )
            
        case is TodaysFoodView.Type: return AnyView (
            TodaysFoodView(foods: $data.foodDataManager.foods, isUpdating: $data.foodDataManager.isUpdating)
        )
        case is TodaysCalendarView.Type: return AnyView (
            TodaysCalendarView(calendarDataManager: $data.calendarDataManager, isUpdating: $data.calendarDataManager.isUpdating)
                .padding(.horizontal, 20)
        )
            
        case is LatestArticleView.Type: return AnyView (
            LatestArticleView(gigantea: $data.giganteaDataManager.gigantea)
        )
            
        default: return AnyView(EmptyView())
        }
    }
}

private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

private struct HeaderSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct ScrollViewOffset<Content: View>: View {
    let content: () -> Content
    let onOffsetChange: (CGFloat) -> Void
    
    init(@ViewBuilder content: @escaping () -> Content,
         onOffsetChange: @escaping (CGFloat) -> Void) {
        self.content = content
        self.onOffsetChange = onOffsetChange
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            offsetReader
            content()
                .padding(.top, -8) // 👈🏻 places the real content as if our `offsetReader` was not there.
        }
        .coordinateSpace(name: "frameLayer")
        .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
    }
    
    var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("frameLayer")).minY
                )
        }
        .frame(height: 0) // 👈🏻 make sure that the reader doesn't affect the content height
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        //        NavigationView {
        //            HomeView()
        //                /*.environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker"), schedule: nil))*/
        //                .environmentObject(AuthManager())
        //                .navigationBarTitle("")
        //                .navigationBarHidden(true)
        //        }
        
        HomeView().headerComponents
    }
}
