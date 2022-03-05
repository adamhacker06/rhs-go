//
//  ProfileView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/21/22.
//

import SwiftUI
import UniformTypeIdentifiers
import MessageUI

struct MyDropDelegate : DropDelegate {

    let item : String
    
    @Binding var items : [String]
    @Binding var draggedItem : String?
    @Binding var viewArray: [Any]
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }

    func dropEntered(info: DropInfo) {
        guard let draggedItem = self.draggedItem else {
            return
        }

        if draggedItem != item {
            let from = items.firstIndex(of: draggedItem)!
            let to = items.firstIndex(of: item)!
            
            viewArray = []
            
            withAnimation(.default) {
                self.items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
                
                for item in self.items {
                    
                    viewArray.append(TileTypesEnum.init(rawValue: item)!.type())
                    
                }
                
                let defaults = UserDefaults.standard
                let encoder = JSONEncoder()
                
                if let encodedTileOrderData = try? encoder.encode(items) {
                    defaults.set(encodedTileOrderData, forKey: "tileOrder")
                }
            }
            
        }
    }
}

enum TileTypesEnum: String, CaseIterable {
    
    case classes = "Schedule"
    case foods = "Food"
    case calendar = "Upcoming Events"
    case article = "Gigantea"
    case extracurriculars = "Featured Extracurriculars"
    
    func type() -> Any {
        
        switch self {
        case .classes:
            return TodaysClassesView.self
        case .foods:
            return TodaysFoodView.self
        case .calendar:
            return TodaysCalendarView.self
        case .article:
            return LatestArticleView.self
        case .extracurriculars:
            return FeaturedExtracurricularsView.self
        }
        
    }
    
}

struct SettingsView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var viewArray: [Any]
    
    @Binding var items: [String]
    
    @State var emailResult: Result<MFMailComposeResult, Error>? = nil
    
    @State private var draggedItem : String?
    
    @State private var showAboutPage: Bool = false
    @State private var showEmailSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            headerComponents
            
            
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        VStack(spacing: 15) {
                            
                            Text("Drag the blocks below to reorder the tiles on the home screen")
                                .italic()
                                .foregroundColor(Color.white)
                                .font(.custom("PublicSans-Light", size: 16))
                            
                            ForEach(items, id:\.self) { item in
                                Text(item)
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .foregroundColor(Color.theme.lapiz)
                                    .font(.custom("PublicSans-SemiBold", size: 16))
                                    .background(Color.white.cornerRadius(10))
                                    .onDrag({
                                        self.draggedItem = item
                                        return NSItemProvider(item: nil, typeIdentifier: item)
                                    }) .onDrop(of: [UTType.text], delegate: MyDropDelegate(item: item, items: $items, draggedItem: $draggedItem, viewArray: $viewArray))
                            }
                        }
                        .padding()
                        .background(Color.theme.lapiz.cornerRadius(10))
                        
                        reportAnIssueButton
                         
                        showAboutPageButton
                        
                        Image("rhs_logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        
                    }
                    .padding(15)
                    
                    
                }
                
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $showEmailSheet) {
            SendMailView(result: $emailResult, components: EmailComponents(subject: "Bug Issue for RHS Go", recipients: ["javila01@vusd.org"], receipiantType: .to, bodyContent: "Hello, I have found an issue with RHS Go. Please read below."))
        }
        .background {
            NavigationLink("", isActive: $showAboutPage) {
                AboutView()
                    .navigationTitle("")
                    .navigationBarHidden(true)
            }
        }
    }
}

struct AboutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            headerComponents
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("RHS Go (the App), unless otherwise noted, was created entirely from scratch by Adam Hacker. The App was developed through Xcode by Apple, Inc. using the SwiftUI framework by Apple, Inc. ")
                    
                    Text("Any social media glyphs or icons were used under their respective brand guidelines.")
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Social media icons were provided by icons8 in their SF Symbols Social Media pack.")
                        
                        Link(destination: URL(string: "https://icons8.com")!) {
                            Text("https://icons8.com")
                        }
                    }
                    
                    Text("The Redwood High School (the School) food nutritional information was provided by the School Nutrition Network software.")
                    
                    Text("Firebase by Google (Firebase) was used to store the data of the app, including but not limited to the School classes, the School teachers, the School food options, the School food nutritional information, and any and all information related to those items.")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Firebase, through Google Analytics for Firebase, may log user actions such as click events, average engagement time, app stability, and more.")
                        
                        Text("Any analytical data collected on the user can not be used to identify the user in any way.")
                        
                        Text("The App does not question the user for any personal information and therefore does not log or store any personal information relating to the user locally or in an online backend.")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Google Calendar API for Developers was used to manage the calendar events featured in the App.")
                        
                        Text("The Redwood High School logo was used with permission in the app logo and all relating assets.")
                        
                        Text("Use of the font \"Public Sans\" is allowed under the Open Font License Agreement. ")
                        
                        Text("Previously mentioned items and other assets used within the App may also be covered by the Fair Use Guidelines for Educational Use.")
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("The articles from the School newspaper were obtained through the Redwood Gigantea website using the WPZOOM RSS entries feed.")
                        
                        Link(destination: URL(string: "https://redwoodgigantea.com")!) {
                            Text("https://redwoodgigantea.com")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Firebase is a trademark of Google, LLC.")
                        
                        Text("Google Analytics is a trademark of Google, LLC.")
                        
                        Text("Google Calendar is a trademark of Google, LLC.")
                        
                        Text("Instagram is a trademark of Instagram, LLC.")
                        
                        Text("The School Nutrition Network software is a copyright of ISITE Software, LLC.")
                        
                        Text("Twitter is a trademark of Twitter, Inc.")
                        
                        Text("WPZoom is a trademark of WPZOOM, B.V.")
                    }
                    
                }
                .padding()
            }
        }
    }
}

extension AboutView {
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("About")
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

extension SettingsView {
    
    private var reportAnIssueButton: some View {
        Button(action: { showEmailSheet = true }) {
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
    
    private var showAboutPageButton: some View {
        Button(action: { showAboutPage = true }) {
            HStack {
                
                Text("About")
                    .font(.custom("PublicSans-Bold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "info.circle")
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
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
