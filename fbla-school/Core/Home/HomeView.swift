//
//  HomeView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/22/21.
//

import SwiftUI
//import GoogleSignIn

extension HomeView {
    
    var headerComponents: some View {
        VStack(spacing: 0) {
            
            if showHeader {
                VStack(spacing: 10) {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                
                                Text("Welcome Back")
                                
//                                Image("rhs_logo")
//                                    .resizable()
//                                    .frame(width: 50, height: 50)
//                                    .cornerRadius(10)
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("PublicSans-Bold", size: 24))
                        
                    }
                    
                    Text("It's a great day to be a Ranger!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background {
                    ZStack {
                        
                        Color.theme.lapiz.ignoresSafeArea()
                        
//                        Image("rhs_logo")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .opacity(0)
                        
                    }
                }
//                .clipped()
                .transition(.move(edge: .top))
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    
                    Button(action: {
                        InstagramManager.openInstagramProfile(handle: "rhsrangers")
                        
                    } ) {
                        HStack {
                            
                            Image("instagram")
                                .font(.system(size: 20))
                            
                            Text("Instagram")
                                .font(.custom("PublicSans-Medium", size: 15))
                            
                        }
                        .foregroundColor(Color.theme.lapiz)
                    }
                    //.frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                    
//                    Rectangle()
//                        .frame(width: 2.5, height: 30)
//                        .foregroundColor(Color.init(hex: 0xf5f5f5))
                    
                    Button(action: { showMessaging = true } ) {
                        HStack {
                            
                            Image(systemName: "paperplane")
                                .font(.system(size: 20))
                            
                            Text("Message")
                                .font(.custom("PublicSans-Medium", size: 15))
                            
                        }
                        .foregroundColor(Color.theme.lapiz)
                    }
                    //.frame(maxWidth: UIScreen.main.bounds.width * 0.5)
                    .background {
                        NavigationLink("", isActive: $showMessaging) {
                            MessagingView()
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: { showProfile = true }) {
                        Image(systemName: "gear")
                            .foregroundColor(Color.theme.lapiz)
                            .font(.system(size: 20))
                    }
                
                }
                .padding(10)
                
//                Rectangle()
//                    .frame(height: 5)
//                    .foregroundColor(Color.init(hex: 0xf5f5f5))
            }
            
            .background(Color.white.ignoresSafeArea())
            
        }
        
        .background {
            
            GeometryReader { geo in
                ZStack {
                    NavigationLink("", isActive: $showProfile) {
                        SettingsView(viewArray: $tileTypes, items: $tileTypesString)
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
    
    @State private var tileTypes: [Any] = []
    @State private var tileTypesString: [String] = []
    
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
                        
                        //if showHeader {
                            Color.clear
                                .frame(width: headerSize.width, height: headerSize.height)
//                                .transition(.move(edge: .top))
                       // }
                        
                        ForEach(0..<tileTypes.count, id: \.self) { index in
                            self.buildView(types: tileTypes, index: index)
                        }
                        .padding(.top, 20)
                        .background {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(
                                        key: OffsetPreferenceKey.self,
                                        value: proxy.frame(in: .named("frameLayer")).minY
                                    )
                            }
                        }
                    }
                } onOffsetChange: { offset in
                    scrollOffset = offset
                }
                .frame(maxWidth: .infinity
                       //, minHeight: Screen.main.bounds.height
                       , maxHeight: .infinity)
                .background(Color.init(hex: 0xf5f5f5).ignoresSafeArea())
                
                
            }
            
            
        }
        .animation(Animation.spring(), value: showHeader)
        .animation(Animation.spring(), value: headerSize)
        .onAppear {
            
            if tileTypes.isEmpty || tileTypesString.isEmpty {
                
                self.tileTypes = []
                self.tileTypesString = []
                
                let defaults = UserDefaults.standard
                
                if let tileOrderData = defaults.object(forKey: "tileOrder") as? Data {
                
                    let decoder = JSONDecoder()
                    
                    if let loadedTileOrderStrings = try? decoder.decode([String].self, from: tileOrderData) {
                        
                        for tileString in loadedTileOrderStrings {
                            
                            self.tileTypes.append(TileTypesEnum.init(rawValue: tileString)!.type())
                            self.tileTypesString.append(tileString)
                            
                        }

                    }
                    
                } else {
                    
                    self.tileTypes = [TodaysClassesView.self, TodaysFoodView.self, TodaysCalendarView.self, LatestArticleView.self, FeaturedExtracurricularsView.self]
                    
                    self.tileTypesString = ["Schedule", "Food", "Gigantea", "Upcoming Events", "Featured Extracurriculars"]
                }
            }
        }
    }
    
    func buildView(types: [Any], index: Int) -> AnyView {
        switch types[index].self {
        
        case is TodaysClassesView.Type: return AnyView (
        
            TodaysClassesView(showEditSchedule: $showEditSchedule)
//                .onAppear {
//
//                    data.scheduleDataManager.schedule = Development.schedule
//
//                }
                .padding(.horizontal, 20)
        )
            
//        case is TodaysClassesView.Type: return AnyView (
//            TodaysClassesView(showEditSchedule: $showEditSchedule)
//                .padding(.horizontal, 20)
//        )
            
        case is TodaysFoodView.Type: return AnyView (
            TodaysFoodView(foods: $data.foodDataManager.foods, isUpdating: $data.foodDataManager.isUpdating)
        )
        case is TodaysCalendarView.Type: return AnyView (
            TodaysCalendarView(calendarDataManager: $data.calendarDataManager, isUpdating: $data.calendarDataManager.isUpdating)
                .padding(.horizontal, 20)
        )
            
        case is LatestArticleView.Type: return AnyView (
            LatestArticleView(gigantea: $data.giganteaDataManager.gigantea)
                .padding(.horizontal, 20)
        )
        
        case is FeaturedExtracurricularsView.Type: return AnyView (
            FeaturedExtracurricularsView()
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
                .padding(.top, -8)
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
        
        let dataManager = DataManager()
        
        //        NavigationView {
        //            HomeView()
        //                /*.environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker"), schedule: nil))*/
        //                .environmentObject(AuthManager())
        //                .navigationBarTitle("")
        //                .navigationBarHidden(true)
        //        }
        
        HomeView()
            .onAppear {
                dataManager.scheduleDataManager.schedule = Development.schedule
            }
            .environmentObject(dataManager)
    }
}
