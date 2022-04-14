//
//  EditSchedulePeriodView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/28/22.
//

import SwiftUI

struct EditSchedulePeriodView: View {
    @EnvironmentObject var data: DataManager
    
    let period: ClassPeriodEnum
//    @Binding var test: Bool
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Period \(period.rawValue)")
                    .font(.custom("PublicSans-SemiBold", size: 18))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
//                HStack(spacing: 10) {
//                    Text("Custom")
//                        .font(.custom("PublicSans-Regular", size: 12))
//
//                    Button(action: { test.toggle() }, label: {
//                        ToggleField(isOn: $test)
//                    })
//
//                }
                
            }
            .padding(.vertical, 0)
            
            HStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text(period.getTime(schedule: data.scheduleDataManager.schedule.bellSchedule, for: .starting))
                        .font(.custom("PublicSans-SemiBold", size: 18))
                    
                    Button(action: {
                        
                        // Change class
                        showSheet = true
                        
                    }, label: {
                        HStack(spacing: 0) {
                            Text("Change Class ")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.theme.lapiz)
                        .font(.custom("PublicSans-Medium", size: 14))
                        .padding(5)
                        .background(Color.white.cornerRadius(5))
                            
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
//                if let schedule = data.scheduleDataManager.schedule {
                VStack(alignment: .trailing, spacing: 2) {
                        
                    Text(data.scheduleDataManager.schedule.get(for: period)?.title ?? "Unselected")
                            .font(.custom("PublicSans-SemiBold", size: 16))
                            .multilineTextAlignment(.trailing)
                        
                    Text(data.scheduleDataManager.schedule.get(for: period)?.administrator ?? "")
                            .font(.custom("PublicSans-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .sheet(isPresented: $showSheet) {
                        EditScheduleSubjectSelectionView(classPeriod: period)
                            .environment(\.showingSheet, $showSheet)
                    }
                    
//                } else {
//                    VStack(spacing: 8) {
//                        Text("Unable to load schedule.")
//                            .font(.custom("PublicSans-SemiBold", size: 12))
//                    }
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                }
                
                
            }
            .padding(10)
            .foregroundColor(.white)
            .background(Color.theme.lapiz.cornerRadius(5))
            .padding(.vertical, 10)
        }
    }
}

struct EditSchedulePeriodView_Previews: PreviewProvider {
    static var previews: some View {
        EditSchedulePeriodView(period: .first)
    }
}
