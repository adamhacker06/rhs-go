//
//  InstagramScheduleView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/19/22.
//

import SwiftUI

struct InstagramScheduleView: View {
    
    let schedule: ClassSchedule
    
    var body: some View {
        
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    Text("Redwood High School Class Schedule")
    //                    .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.custom("PublicSans-SemiBold", size: 18))

                }
                
                CustomDivider(color: .white, thickness: 5)
                    .padding(.top, 5)
                
                VStack(spacing: 0) {
                    
                    if !schedule.isEmpty {
                        
                        ForEach(0..<7) { classPeriodInt in
                            
                            let classPeriod = ClassPeriod(rawValue: classPeriodInt)!
                            
                            if let schoolClass = schedule.get(for: classPeriod) {
                                
                                ClassOverView(schoolClass: schoolClass, classPeriod: classPeriod)
                                    .padding(.top)
                                
                            }

                        }
                        
    //                    ForEach((scheduleDataManager.hasPrefirst ? 0 : 1)..<7) { classPeriod in
    //                        ClassOverView(schoolClass: scheduleDataManager.schedule[ClassPeriod(rawValue: classPeriod)!] ?? SchoolClass(administrator: "Unselected", namePrefix: .mr, title: "Unselected", email: "Unknown"), classPeriod: ClassPeriod(rawValue: classPeriod)!)
    //                            .padding(.top, 18)
    //                    }
                        
                    } else {
                        
                       Text("No classes selected")
                        
                    }
                }
                .padding(.bottom)
                
                CustomDivider(color: Color(hex: 0xf5f5f5), thickness: 5)
                
                Text("Created by Redwood High School Helper")
                    .foregroundColor(.white)
                    .padding(.vertical)
                
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 18)
            .background(Color.theme.lapiz)
        
    }
}

//struct InstagramScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        InstagramScheduleView()
//    }
//}
