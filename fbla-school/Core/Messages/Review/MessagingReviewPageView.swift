//
//  MessagingReviewPageView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/17/22.
//

import SwiftUI
import MessageUI

struct MessagingReviewPageView: View {
    
    @EnvironmentObject var data: DataManager
    @EnvironmentObject var vm: MessagingViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingSendMailView: Bool = false
    @State private var emailResult: Result<MFMailComposeResult, Error>? = nil
    
    @State private var itemStore: Array<AnyInformation>? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                
                Spacer()
                
                Text("Review")
                    .font(.custom("PublicSans-SemiBold", size: 30))
                    .foregroundColor(Color.theme.black)
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal)
                
            }
            .padding([.bottom, .horizontal])
            .background {
                Color.white.ignoresSafeArea()
                    .shadow(radius: 5)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        Text("Selected")
                            .font(.custom("PublicSans-Medium", size: 20))
                        
                        if let itemStore = itemStore {
                            if itemStore.isEmpty {
                                Text("No emails were selected. Please go back")
                            } else {
                                selectedItemsList
                            }
                        } else {
                            Text("No emails were selected. Please go back")
                        }
                        
                        CustomDivider(color: Color(hex: 0xf5f5f5), thickness: 5)
                        
                        optionsList
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                }
                
                if !MFMailComposeViewController.canSendMail() {
                    
                    Text("Your device is not able to send mail. Please ensure the Mail app is installed on your phone and is properly configured.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            Color.theme.lightBlue.ignoresSafeArea()
                        }
                    
                    
                }
                
                footerComponents
            }
            
        }
        .sheet(isPresented: $isShowingSendMailView) {
            
            SendMailView(result: $emailResult, components: vm.createEmailComponents())
            
        }
        .onAppear {
            itemStore = vm.selectedItems
        }
        
    }
}

extension MessagingReviewPageView {
    private var footerComponents: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .overlay {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 40)
                
            }
            
            Spacer(minLength: 30)
            
            Button(action: {
                
                isShowingSendMailView = true
                
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .overlay {
                        HStack {
                            Text("Prepare")
                                .fontWeight(.bold)
                            
                            Image(systemName: "paperplane.fill")
                                .font(.title3)
                            
                        }
                        .foregroundColor(Color.theme.lapiz)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 40)
                
            }
            .disabled(!MFMailComposeViewController.canSendMail())
            .opacity(!MFMailComposeViewController.canSendMail() ? 0.7 : 1)
        }
        .foregroundColor(Color.theme.white)
        .padding()
        .background {
            Color.theme.lapiz.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
    
    private var selectedItemsList: some View {
        
        ForEach(itemStore!.indices, id: \.self) { itemIndex in
            
            let item = itemStore![itemIndex]
            
            HStack {
                EmailListItem(for: item, showCheckBox: false, selectedItems: $vm.selectedItems)
                
                Spacer()
                
                Text(item.email)
                
                EmailCheckboxView(selectedItems: $vm.selectedItems, item: item)
            }
            
            
        }
    }
    
    private var optionsList: some View {
        VStack(alignment: .leading) {
            Text("Options")
                .font(.custom("PublicSans-Medium", size: 20))
                .padding(.top, 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Send as BCC (Blind Carbon Copy)")
                        .font(.custom("PublicSans-SemiBold", size: 16))
                        .foregroundColor(Color.theme.lapiz)
                    
                    Text("Receipiants will be hidden from each other")
                        .font(.custom("PublicSans-Medium", size: 14))
                        .foregroundColor(Color.theme.black)
                }
                
                Spacer()
                
                CheckBoxView(isChecked: { vm.emailReceipiantType == .bcc } ) {
                    
                    vm.emailReceipiantType = .bcc
                    
                }
                .disabled(vm.emailReceipiantType == .bcc)
                
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Send as CC (Carbon Copy)")
                        .font(.custom("PublicSans-SemiBold", size: 16))
                        .foregroundColor(Color.theme.lapiz)
                    
                    Text("Receipiants will be aware of others who received the email")
                        .font(.custom("PublicSans-Medium", size: 14))
                        .foregroundColor(Color.theme.black)
                }
                
                Spacer(minLength: 30)
                
                CheckBoxView(isChecked: { vm.emailReceipiantType == .cc } ) {
                    
                    vm.emailReceipiantType = .cc
                    
                }
                .disabled(vm.emailReceipiantType == .cc)
                
            }
        }
    }
}

struct MessagingReviewPageView_Previews: PreviewProvider {
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
        
        NavigationView {
            MessagingReviewPageView()
                .navigationTitle("")
                .navigationBarHidden(true)
//                .environmentObject(dataManager1)
                .environmentObject(MessagingViewModel())
        }
        
    }
}
