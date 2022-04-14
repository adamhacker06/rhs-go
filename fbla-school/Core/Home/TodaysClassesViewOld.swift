//
//  TodaysClassesViewOld.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/28/21.
//

import SwiftUI
import Social

extension TodaysClassesViewOld {
    private func editButton(labelText: String) -> some View {
        
        Button(action: { showEditSchedule = true; print("tapped") } ) {
            Text(labelText)
                .underline()
                .foregroundColor(.white)
                .font(.custom("PublicSans-Regular", size: 16))
        }
    }
}

struct TodaysClassesViewOld: View {
    
    @EnvironmentObject var data: DataManager
    @Binding var showEditSchedule: Bool
    
    @State private var showSharingScreen: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                Text("Today's Classes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.custom("PublicSans-SemiBold", size: 18))
                
                editButton(labelText: "Edit")
                
            }
            
            CustomDivider(color: .white, thickness: 5)
                .padding(.top, 5)
            
            VStack(spacing: 0) {
                
                if !data.scheduleDataManager.schedule.isEmpty {
                    
                    ForEach(0..<7) { classPeriod in
                        
                        if let schoolClass = data.scheduleDataManager.schedule.get(for: ClassPeriodEnum(rawValue: classPeriod)!) {
                            ClassOverView(classPeriod: ClassPeriodEnum(rawValue: classPeriod)!, bellSchedule: data.scheduleDataManager.schedule.bellSchedule, schoolClass: schoolClass)
                                .padding(.top, 18)
                        }
                    }
                    
                } else {
                    
                    editButton(labelText: "Click here to set up a schedule")
                        .padding(.top, 18)
                    
                }
            }
            .padding(.bottom)
            
            if !data.scheduleDataManager.schedule.isEmpty {
                
                CustomDivider(color: Color(hex: 0xf5f5f5), thickness: 5)
                
                HStack(spacing: 10) {
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .font(.title2)
                        .onTapGesture {
                            
                        showSharingScreen = true
                        
                        }
                    
                }
                .padding(.top)
            }
            
            
            
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .horizontal], 15)
        .padding(.bottom, 18)
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
        .cornerRadius(10)
        
    }
}

struct YourDayView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
//            let data = DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker"), schedule: nil)
//            let data2 = DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker"), schedule: [.first:SchoolClass(teacher: "Mr. Guerror", namePrefix: .mr, className: "Spanish 2", email: "Unknown")])
            
            TodaysClassesViewOld(showEditSchedule: .constant(false))
                .environmentObject(DataManager())
//                .environmentObject(data2)
        }
    }
}
