//
//  EditScheduleView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI

struct EditScheduleView: View {
    
    @EnvironmentObject var data: DataManager
    
    var body: some View {
        ZStack {
            Color.theme.lapiz.ignoresSafeArea()
            VStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("Your Schedule")
                        .font(.custom("PublicSans-SemiBold", size: 24))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Rectangle()
                        .frame(maxWidth: 100, maxHeight: 5)
                        .foregroundColor(.white)
                        .padding(.top, 3)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 10) {
                    Text("Include Prefirst")
                        .font(.custom("PublicSans-Regular", size: 15))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                    
                    Circle()
                        .frame(maxWidth:16, maxHeight: 16)
                    
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        ForEach((data.user!.hasPrefirst ? 0 : 1)..<7) { classPeriod in
                            
                            VStack(spacing: 0) {
                                
                                EditSchedulePeriodView(period: ClassPeriod(rawValue: classPeriod)!)
//                                    .padding(.top, data.user!.hasPrefirst ? (classPeriod > 0 ? 10 : 0) : (classPeriod > 1 ? 10 : 0))
                                
                                if classPeriod < 6 {
                                    Rectangle()
                                        .frame(width: .infinity, height: 5)
                                        .foregroundColor(Color(hex: 0xE5E5E5))
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
            .padding([.horizontal, .top], 20)
        }
    }
}

struct EditSchedulePeriodView: View {
    
    @EnvironmentObject var data: DataManager
    
    let period: ClassPeriod
    
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
                    
                    Circle()
                        .frame(width: 16, height: 16)
                }
            }
            .padding(.vertical, 10)
            
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
            .padding(.bottom, 10)
        }
    }
}

struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView().environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")
                                                         , schedule: [.prefirst:SchoolClass(teacher: "Mr. Gurerro", namePrefix: .mr, className: "Spanish 2")]
        ))
    }
}
