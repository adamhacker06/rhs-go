//
//  MessagingViewModel.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 2/14/22.
//

import SwiftUI
import MessageUI

class MessagingViewModel: ObservableObject {
    
    @Published var emailReceipiantType: ReceipiantTypes = .bcc
    @Published var selectedItems: Array<AnyInformation> = []
    
    var recipientList: [String] {
        
        var emailStore: [String] = []
        
        for item in selectedItems {
            emailStore.append(item.email)
        }
        
        return emailStore
    }
    
    func createEmailComponents(subject: String? = nil) -> EmailComponents {
        
        return EmailComponents(subject: subject == nil ? "Message" : subject!, recipients: recipientList, receipiantType: emailReceipiantType, bodyContent: "Hello!")
        
    }
    
    enum ReceipiantTypes {
        case cc
        case bcc
    }
}

struct EmailComponents {
    
    let subject: String
//    let senderEmail: String
    let recipients: [String]
    let receipiantType: MessagingViewModel.ReceipiantTypes
    let bodyContent: String

}

struct SendMailView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    let components: EmailComponents
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(presentationMode: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentationMode = presentationMode
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            defer { $presentationMode.wrappedValue.dismiss() }
            
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            
            self.result = .success(result)
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, result: $result)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SendMailView>) -> MFMailComposeViewController {
        
        let vc = MFMailComposeViewController()
        
        vc.setSubject(components.subject)
//        vc.setPreferredSendingEmailAddress(components.senderEmail)
        
        switch components.receipiantType {
        case .bcc:
            vc.setBccRecipients(components.recipients)
            
        case .cc:
            vc.setCcRecipients(components.recipients)
        }
        
        vc.setMessageBody(components.bodyContent, isHTML: false)
        
        vc.mailComposeDelegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<SendMailView>) { }
}
