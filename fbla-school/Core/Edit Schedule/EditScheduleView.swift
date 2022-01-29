//
//  EditScheduleView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI

struct EditScheduleView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var test: Bool = false
    @State private var showPrefirst: Bool = false
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.lapiz.ignoresSafeArea()
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    
                    Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    })
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        Text("Your Schedule")
                            .font(.custom("PublicSans-SemiBold", size: 32))
                            .foregroundColor(.white)
                            //.frame(maxWidth: .infinity, alignment: .leading)
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .padding(.top, 3)
                            .frame(maxWidth: 100, maxHeight: 5)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                HStack(spacing: 10) {
                    Text("Include Prefirst")
                        .font(.custom("PublicSans-Regular", size: 16))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                    
                    ToggleField(isOn: $showPrefirst)
                    
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        ForEach((data.user!.hasPrefirst ? 0 : 1)..<7) { classPeriod in
                            
                            VStack(spacing: 0) {
                                
                                EditSchedulePeriodView(period: ClassPeriod(rawValue: classPeriod)!, test: $test)
//                                    .padding(.top, data.user!.hasPrefirst ? (classPeriod > 0 ? 10 : 0) : (classPeriod > 1 ? 10 : 0))
                                
                                if classPeriod < 6 {
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: 5)
                                        .foregroundColor(Color(hex: 0xE5E5E5))
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    
                }
                .background(Color.white.cornerRadius(25, corners: [.topLeft, .topRight]))
                .ignoresSafeArea()
                
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
        }
    }
}

struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView().environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")
                                                         , schedule: [.fourth:SchoolClass(teacher: "Mr. Gurerro", namePrefix: .mr, className: "Spanish 2")]
        ))
        
//        EditScheduleView().environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")
//                                                         , schedule: [.fourth:SchoolClass(teacher: "Mr. Gurerro", namePrefix: .mr, className: "Spanish 2")]
//        )).previewDevice("iPod touch (7th generation)")
    }
}
