//
//  ProfileView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/21/22.
//

import SwiftUI
import UniformTypeIdentifiers

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
    
    @State var draggedItem : String?
    
    var body: some View {
        VStack(spacing: 0) {
            headerComponents
            
            VStack(spacing: 0) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    reportAnIssueButton
                     
                    LazyVStack(spacing : 15) {
                        ForEach(items, id:\.self) { item in
                            Text(item)
                                .frame(minWidth:0, maxWidth:.infinity, minHeight:50)
                                .border(Color.black).background(Color.red)
                                .onDrag({
                                    self.draggedItem = item
                                    return NSItemProvider(item: nil, typeIdentifier: item)
                                }) .onDrop(of: [UTType.text], delegate: MyDropDelegate(item: item, items: $items, draggedItem: $draggedItem, viewArray: $viewArray))
                        }
                    }
                    
                }
                
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

extension SettingsView {
    
    private var reportAnIssueButton: some View {
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
