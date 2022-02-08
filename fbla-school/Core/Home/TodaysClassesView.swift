//
//  YourDayView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/28/21.
//

import SwiftUI

extension TodaysClassesView {
    private func editButton(labelText: String) -> some View {
        NavigationLink(
            destination:
                EditScheduleView()
                .navigationTitle("")
                .navigationBarHidden(true)
            ,
            isActive: $showEditSchedule,
            label: {
                Text(labelText)
                    .underline()
                    .foregroundColor(.white)
                    .font(.custom("PublicSans-Normal", size: 16))
            })
    }
}

struct TodaysClassesView: View {
    
    @EnvironmentObject var data: DataManager
    @Binding var showEditSchedule: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                Text("Today's Classes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.custom("PublicSans-SemiBold", size: 18))
                
                editButton(labelText: "Edit")

//                Image(systemName: "chevron.down")
//                    .foregroundColor(.white)
            }
            
            CustomDivider(color: .white, thickness: 5)
                .padding(.top, 5)
            
            VStack(spacing: 0) {
                
                if data.scheduleDataManager.schedule != [:] {
                    
                    ForEach((data.scheduleDataManager.hasPrefirst ? 0 : 1)..<7) { classPeriod in
                        ClassOverView(schoolClass: data.scheduleDataManager.schedule[ClassPeriod(rawValue: classPeriod)!] ?? SchoolClass(teacher: "Unselected", namePrefix: .mr, className: "Unselected"), classPeriod: ClassPeriod(rawValue: classPeriod)!)
                            .padding(.top, 18)
                    }
                    
                } else {
                    
                    editButton(labelText: "Click here to set up a schedule")
                        .padding(.top, 18)
                    
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .horizontal], 15)
        .padding(.bottom, 18)
        .background(Color.theme.lapiz)
        .cornerRadius(10)
        
        
    }
}

struct ClassOverView: View {
    
    var schoolClass: SchoolClass
    var classPeriod: ClassPeriod
    
    var body: some View {
        HStack(spacing: 0) {
            Text(classPeriod.getTime(for: .starting))
                .font(.custom("PublicSans-SemiBold", size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(schoolClass.className)
                    .foregroundColor(.theme.lapiz)
                    .multilineTextAlignment(.trailing)
                    .font(.custom("PublicSans-SemiBold", size: 14))
                
                Text(schoolClass.namePrefix.rawValue + " " + schoolClass.teacher.lastName())
                    .font(.custom("PublicSans-Regular", size: 12))
                    .opacity(schoolClass.className == "Unselected" ? 0 : 1)
                
            }
            .padding(6)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color.white)
            .cornerRadius(5)
        }
    }
}

struct YourDayView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            let data = DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker"), schedule: nil)
            let data2 = DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker"), schedule: [.first:SchoolClass(teacher: "Mr. Guerror", namePrefix: .mr, className: "Spanish 2")])
            
            TodaysClassesView(showEditSchedule: .constant(false)).environmentObject(data2)
        }
    }
}
