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
    
    @State var test: Bool = false
    @State var showPrefirst: Bool = false
    
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
                .navigationViewStyle(StackNavigationViewStyle())
                .background(Color.white.cornerRadius(25, corners: [.topLeft, .topRight]))
                .ignoresSafeArea()
                
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
        }
    }
}

struct EditSchedulePeriodView: View {
    
    @EnvironmentObject var data: DataManager
    
    let period: ClassPeriod
    @Binding var test: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Period \(period.rawValue)")
                    .font(.custom("PublicSans-SemiBold", size: 18))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 10) {
                    Text("Custom")
                        .font(.custom("PublicSans-Regular", size: 12))
                    
                    Button(action: { test.toggle() }, label: {
                        ToggleField(isOn: $test)
                    })
                    
                }
                
            }
            .padding(.vertical, 0)
            
            HStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text(period.getTime(for: .starting))
                        .font(.custom("PublicSans-SemiBold", size: 18))
                    
                    Button(action: {
                        
                        // Change class
                        
                    }, label: {
                        HStack(spacing: 0) {
                            Text("Change Class ")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.theme.lapiz)
                        .font(.custom("PublicSans-Medium", size: 10))
                        .padding(5)
                        .background(Color.white.cornerRadius(5))
                            
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 8) {
                    Text(data.user!.schedule?[period]?.className ?? "Unselected")
                        .font(.custom("PublicSans-SemiBold", size: 12))
                    
                    Text(data.user!.schedule?[period]?.teacher ?? "")
                        .font(.custom("PublicSans-Regular", size: 10))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(10)
            .foregroundColor(.white)
            .background(Color.theme.lapiz.cornerRadius(5))
            .padding(.vertical, 10)
        }
    }
}

struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView().environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")
                                                         , schedule: [.fourth:SchoolClass(teacher: "Mr. Gurerro", namePrefix: .mr, className: "Spanish 2")]
        ))
        
        EditScheduleView().environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")
                                                         , schedule: [.fourth:SchoolClass(teacher: "Mr. Gurerro", namePrefix: .mr, className: "Spanish 2")]
        )).previewDevice("iPod touch (7th generation)")
    }
}
