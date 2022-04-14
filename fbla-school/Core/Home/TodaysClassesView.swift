//
//  TodaysClassesView.swift
//  RHS Go
//
//  Created by Adam Hacker on 4/11/22.
//

import SwiftUI

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
            
            // body
            VStack(spacing: 0) {
                
                if !data.scheduleDataManager.schedule.isEmpty {
                    
                    ForEach(0..<7) { classPeriod in
                        
                        if let schoolClass = data.scheduleDataManager.schedule.get(for: ClassPeriodEnum(rawValue: classPeriod)!) {
                            ClassOverView(classPeriod: ClassPeriodEnum(rawValue: classPeriod)!, bellSchedule: data.scheduleDataManager.schedule.bellSchedule, schoolClass: schoolClass)
                                .padding(.top, 10)
                        }
                    }
                    
                } else {
                    
                    Button(action: { showEditSchedule = true } ) {
                        Text("Set up a schedule")
                            .font(.publicSans, weight: .regular, size: 16)
                            .foregroundColor(.theme.lapiz)
                            .underline()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                }
                
            }
            .padding([.horizontal, .bottom], 10)
            .background(Color.white)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        
    }
}

func actionSheet(image: UIImage) {
    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    
    windowScene?.windows.first?.rootViewController?
        .present(activityVC, animated: true, completion: nil)
}

struct ClassOverView: View {
    
    let classPeriod: ClassPeriodEnum
    let bellSchedule: BellSchedule
    let schoolClass: SchoolClass
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(classPeriod.rawValue)" +  " | " + classPeriod.getTime(schedule: bellSchedule, for: .starting))
                .font(.custom("PublicSans-SemiBold", size: 18))
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(schoolClass.title)
                    .foregroundColor(.theme.lapiz)
                    .multilineTextAlignment(.trailing)
                    .font(.custom("PublicSans-SemiBold", size: 14))
                
                Text(schoolClass.namePrefix.rawValue + " " + schoolClass.administrator.lastName())
                    .foregroundColor(Color.black)
                    .font(.custom("PublicSans-Regular", size: 12))
                    .opacity(schoolClass.title == "Unselected" ? 0 : 1)
                
            }
            .padding(6)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color.init(hex: 0xf5f5f5))
            .cornerRadius(5)
        }
    }
}

struct TodaysClassesView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let data = DataManager()
        
        ZStack {
            
            Color.init(hex: 0xf5f5f5)
                .ignoresSafeArea()
            
            
            TodaysClassesView(showEditSchedule: .constant(false))
//                .onAppear {
//                    data.scheduleDataManager.schedule = Development.schedule
//                }
                .environmentObject(data)
            .padding(.horizontal, 20)
        }
    }
}
