//
//  EditScheduleView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/29/21.
//

import SwiftUI

extension EditScheduleView {
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("Edit Schedule")
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.lapiz.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
}

struct EditScheduleView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //    @State private var test: Bool = false
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        
        
        
        VStack(spacing: 0) {
            
            headerComponents
                
            /*HStack(spacing: 10) {
                Text("Include Prefirst")
                .font(.custom("PublicSans-Regular", size: 16))
                .foregroundColor(.white)
                .padding(.vertical, 15)
                
                ToggleField(isOn: $data.scheduleDataManager.showPrefirst)
                .onTapGesture {
                
                if data.scheduleDataManager.showPrefirst {
                //
                ////                                    data.scheduleDataManager.schedule[.prefirst] = SchoolClass(administrator: "Unselected", namePrefix: .mr, title: "Unselected", email: "Unknown")
                //
                //                                    withAnimation { data.scheduleDataManager.showPrefirst = false }
                //
                //                                } else {
                ////
                ////                                    data.scheduleDataManager.schedule[.prefirst] = SchoolClass(administrator: "Unselected", namePrefix: .mr, title: "Unselected", email: "Unknown")
                ////
                //                                    withAnimation { data.scheduleDataManager.showPrefirst = true }
                }
                
                }
                
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .trailing)*/
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    ForEach(ClassPeriod.allCases.indices, id:
                                \.self) { classPeriod in
                        
                        VStack(spacing: 0) {
                            
                            if let classPeriod = ClassPeriod(rawValue: classPeriod) {
                                
                                //                                    if classPeriod == .prefirst {
                                //
                                //                                        if data.scheduleDataManager.showPrefirst {
                                //                                            EditSchedulePeriodView(period: classPeriod)
                                //                                        }
                                
                                //                                    } else {
                                EditSchedulePeriodView(period: classPeriod)
                                //                                    }
                                
                            }
                            
                            
                            //                                    .padding(.top, data.user!.hasPrefirst ? (classPeriod > 0 ? 10 : 0) : (classPeriod > 1 ? 10 : 0))
                            
                            if classPeriod < 6 {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 5)
                                    .foregroundColor(Color(hex: 0xE5E5E5))
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        print(classPeriod)
                                        print("Wooo")
                                    }
                            }
                        }
                        
                    }
                    
                    //                        ForEach((data.scheduleDataManager.showPrefirst ? 0 : 1)..<7, id: \.self) { classPeriod in
                    //
                    //                            VStack(spacing: 0) {
                    //
                    //                                EditSchedulePeriodView(period: ClassPeriod(rawValue: classPeriod)!)
                    ////                                    .padding(.top, data.user!.hasPrefirst ? (classPeriod > 0 ? 10 : 0) : (classPeriod > 1 ? 10 : 0))
                    //
                    //                                if classPeriod < 6 {
                    //                                    Rectangle()
                    //                                        .frame(maxWidth: .infinity, maxHeight: 5)
                    //                                        .foregroundColor(Color(hex: 0xE5E5E5))
                    //                                        .padding(.bottom, 10)
                    //                                }
                    //                            }
                    //                        }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                
            }
            .background(Color.white)

            
        }
        
        
        
    }
}

struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView()
        /*.environmentObject(
         DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker"), schedule: ScheduleDataManager(lastUpdated: Date(), schedule: [.fourth:SchoolClass(administrator: "Mr. Gurerro", namePrefix: .mr, title: "Spanish 2", email: "Unknown")], cache: SchoolClassesCache()
         )))*/
        
        //        EditScheduleView().environmentObject(DataManager(withDevUser: DevUser(email: "test@test.com", firstName: "Adam", lastName: "Hacker")
        //                                                         , schedule: [.fourth:SchoolClass(teacher: "Mr. Gurerro", namePrefix: .mr, className: "Spanish 2")]
        //        )).previewDevice("iPod touch (7th generation)")
    }
}
