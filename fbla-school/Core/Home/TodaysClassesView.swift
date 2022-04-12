//
//  TodaysClassesView.swift
//  RHS Go
//
//  Created by Adam Hacker on 4/11/22.
//

import SwiftUI

extension Text {
    
    enum Fonts: String {
        case publicSans = "PublicSans"
        
        enum CustomWeights: String {
            case thin = "Thin"
            case extraLight = "ExtraLight"
            case light = "Light"
            case regular = "Regular"
            case medium = "Medium"
            case semiBold = "SemiBold"
            case bold = "Bold"
            case extraBold = "ExtraBold"
            case black = "Black"
        }
    }
    
    func font(_ font: Fonts, weight: Fonts.CustomWeights, size: CGFloat) -> Text {
        self.font(.custom("\(font.rawValue)-\(weight.rawValue)", size: size))
    }
    
}

struct TodaysClassesView: View {
    
    @EnvironmentObject var data: DataManager
    
    @Binding var showEditSchedule: Bool
    
    @State private var showSharingScreen: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // header
            HStack(alignment: .top) {
                VStack(alignment: .leading,  spacing: 3) {
                    
                    Text("Today's Classes")
                        .bold()
                        .font(.publicSans, weight: .medium, size: 18)
                    
                    Text(Date.now.asShortDateString())
                        .font(.publicSans, weight: .regular, size: 16)
                    
                }
                .foregroundColor(.white)
                .font(.custom("PublicSans-Bold", size: 20))
                
                Spacer()
                
                VStack(spacing: 0) {
                    // edit button
                    
                    Button(action: { showEditSchedule = true }) {
                        Text("Edit")
                            .foregroundColor(.white)
                            .font(.publicSans, weight: .regular, size: 16)
                            .underline()
                    }
                }
            }
            .padding()
            .background(
                
                ZStack {
                    
                    NavigationLink("", isActive: $showSharingScreen) {
                        ShareScheduleView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                        
                    }
                    
                    NavigationLink("", isActive: $showEditSchedule) {
                        EditScheduleView()
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    }
                    
                    Color.theme.lapiz
                    
                }
            )
            
            // classes
            VStack(spacing: 0) {
                
                if !data.scheduleDataManager.schedule.isEmpty {
                    
                    ForEach(0..<7) { classPeriod in
                        
                        if let schoolClass = data.scheduleDataManager.schedule.get(for: ClassPeriod(rawValue: classPeriod)!) {
                            ClassOverView(schoolClass: schoolClass, classPeriod: ClassPeriod(rawValue: classPeriod)!)
                                .padding(.top, 10)
                        }
                    }
                    
                } else {
                    
                    Text("Edit schedule")
                    
                }
                
            }
            .padding([.horizontal, .bottom], 10)
            .background(Color.white)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        
    }
}

struct TodaysClassesView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let data = DataManager()
//        data.scheduleDataManager.schedule = Development.schedule
        
        ZStack {
            
            Color.init(hex: 0xf5f5f5)
                .ignoresSafeArea()
            
            
            TodaysClassesView(showEditSchedule: .constant(false))
                .onAppear {
                    data.scheduleDataManager.schedule = Development.schedule
                }
                .environmentObject(data)
            .padding(.horizontal, 20)
        }
    }
}
