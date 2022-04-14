//
//  MessagingView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/13/22.
//

import SwiftUI

struct CustomLabel: View {
    
    let item: CustomLabelInformation
    
    init(for item: CustomLabelInformation) {
        self.item = item
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            Text(item.emoji)
                .font(.title)
                .shadow(radius: 5)
                .frame(maxWidth: 45, maxHeight: 45)
                .overlay(
                    Circle().stroke(Color.theme.lapiz, lineWidth: 2)
                )
            
            Spacer(minLength: 50)
            
            VStack(alignment: .trailing, spacing: 0) {
                Text(item.name)
                    .font(.custom("PublicSans-Bold", size: 18))
                    .foregroundColor(Color.theme.lapiz)
                
                Text(item.description)
                
                    .font(.custom("PublicSans-Light", size: 14))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct EmailListItem: View {
    
    @Binding var selectedItems: Array<AnyInformation>
    
    let item: AnyInformation
    let showCheckBox: Bool
    
    init(for item: AnyInformation, showCheckBox: Bool = true, selectedItems: Binding<Array<AnyInformation>>) {
        
        self.item = item
        self.showCheckBox = showCheckBox
        self._selectedItems = selectedItems
        
    }
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.custom("PublicSans-SemiBold", size: 16))
                    .foregroundColor(Color.theme.lapiz)
                
                Text(item.administrator)
                    .font(.custom("PublicSans-Medium", size: 14))
                    .foregroundColor(Color.theme.black)
            }
            
            if showCheckBox {
                
                Spacer()
                
                EmailCheckboxView(selectedItems: $selectedItems, item: item)
                
            }
        }
    }
}

extension MessagingView {
    private var scheduleList: some View {
        
        Group {
            if data.scheduleDataManager.schedule.isEmpty {
                Text("You have not set up a schedule.")
                    .font(.custom("PublicSans-Regular", size: 18))
                
            } else {
                VStack(spacing: 5) {
                    ForEach(0..<7, id: \.self) { periodNumber in
                        
                        if let classPeriod = ClassPeriodEnum(rawValue: periodNumber) {
                            
                            HStack(spacing: 10) {
                                
                                if let schoolClass = data.scheduleDataManager.schedule.get(for: classPeriod) {
                                    
                                    Text(periodNumber.description)
                                    
                                    EmailListItem(for: schoolClass, selectedItems: $vm.selectedItems)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var footerComponents: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .overlay {
                        Text("Cancel")
                            .font(.custom("PublicSans-Regular", size: 18))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 40)
                
            }
            
            Spacer(minLength: 30)
            
            Button(action: {
                showReviewPage = true
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .overlay {
                        HStack {
                            Text("Review")
                                .font(.custom("PublicSans-Bold", size: 18))
                            
                            Image(systemName: "arrow.right")
                                .font(.title3)
                            
                        }
                        .foregroundColor(Color.theme.lapiz)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 40)
                
            }
            .disabled(vm.selectedItems.isEmpty)
            .opacity(vm.selectedItems.isEmpty ? 0.7 : 1)
        }
        .foregroundColor(Color.theme.white)
        .padding()
        .background {
            Color.theme.lapiz.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
}

struct MessagingView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var vm = MessagingViewModel()
    
    @State private var loadedPeople: [FacultyModel] = []
    @State private var showReviewPage: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                
                Spacer()
                
                Text("Who Would You Like to Message?")
                    .font(.custom("PublicSans-SemiBold", size: 30))
                    .foregroundColor(Color.theme.black)
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal)
                
            }
            .padding()
            .background {
                ZStack {
                    Color.white.ignoresSafeArea()
                        .shadow(radius: 5)
                    NavigationLink("", isActive: $showReviewPage) {
                        MessagingReviewPageView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            .environmentObject(vm)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("From your schedule")
                            .font(.custom("PublicSans-Medium", size: 20))
                            .padding(.top)
                        
                        scheduleList
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomDivider(color: Color(hex: 0xf5f5f5), thickness: 5)
                    
                    VStack(alignment: .leading) {
                        Text("Other")
                            .font(.custom("PublicSans-Medium", size: 20))
                        
                        VStack {
                            
                            ForEach(MessageContentTypes.allCases) { contentType in
                                
                                MessageViewContentTypeLabelView(associatedType: contentType)
                                    .environmentObject(vm)
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                                
                            }
                            .padding(.bottom)
                        }
                    }
                }
                .padding(.horizontal)
                
                footerComponents
                
            }
        }
    }
}

struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        
        /*let dataManager1 = DataManager(
            withDevUser: DevUser(email: "", firstName: "", lastName: ""),
            
            schedule: ScheduleDataManager(
                lastUpdated: Date(),
                schedule: [
                    ClassPeriod.first : SchoolClass(administrator: "Russel Brown", namePrefix: NamePrefix.mr, title: "Intro to Being Cool", email: "rbrown@vusd.org"),
                    
                    ClassPeriod.second : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.prefirst : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.third : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.fourth : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.fifth : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.sixth : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org")
                ]
                
                
                ,cache: SchoolClassesCache()))*/
        
        /*let dataManager2 = DataManager(
            withDevUser: DevUser(email: "", firstName: "", lastName: ""),
            
            schedule: ScheduleDataManager(
                lastUpdated: Date(),
                schedule: [
                    ClassPeriod.first : SchoolClass(administrator: "Russel Brown", namePrefix: NamePrefix.mr, title: "Intro to Being Cool", email: "rbrown@vusd.org"),
                    
                    ClassPeriod.second : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.prefirst : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.third : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.fourth : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.fifth : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org"),
                    
                    ClassPeriod.sixth : SchoolClass(administrator: "Daniel Guerrero", namePrefix: .mr, title: "Spanish 2", email: "dguerrero@vusd.org")
                ]
                
                
                ,cache: SchoolClassesCache()))*/
        
        
        NavigationView {
            MessagingView()
                .navigationTitle("")
                .navigationBarHidden(true)
//                .environmentObject(dataManager1)
        }
        
    }
}
