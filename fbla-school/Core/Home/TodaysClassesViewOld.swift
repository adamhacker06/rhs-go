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
                        
                        if let schoolClass = data.scheduleDataManager.schedule.get(for: ClassPeriod(rawValue: classPeriod)!) {
                            ClassOverView(schoolClass: schoolClass, classPeriod: ClassPeriod(rawValue: classPeriod)!)
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

func actionSheet(image: UIImage) {
    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    
    windowScene?.windows.first?.rootViewController?
        .present(activityVC, animated: true, completion: nil)
}

struct ClassOverView: View {
    
    var schoolClass: SchoolClass
    var classPeriod: ClassPeriod
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(classPeriod.rawValue)" +  " | " + classPeriod.getTime(for: .starting))
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
