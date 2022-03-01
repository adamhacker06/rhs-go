//
//  AddToInstagramStory.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI

class InstagramManager {
    
    static var instagramURLScheme = URL(string: "instagram-stories://share")
    
    static var canOpenInstagram: Bool {
        
        if let instagramURLScheme = self.instagramURLScheme {
            return UIApplication.shared.canOpenURL(instagramURLScheme)
        } else {
            return false
        }
        
    }
    
    static func shareToInstagram(image: UIImage) {
        if let instagramURLScheme = self.instagramURLScheme {
            
            if self.canOpenInstagram {
                
                let image: Data = image.pngData()!
                
                let items = [["com.instagram.sharedSticker.stickerImage" : image, "com.instagram.sharedSticker.backgroundTopColor" : ("#255FA3" as NSString), "com.instagram.sharedSticker.backgroundBottomColor" : ("#ffffff" as NSString)]]
                
                let pasteboardConfig = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(150)]
                
                UIPasteboard.general.setItems(items, options: pasteboardConfig)
                
                UIApplication.shared.open(instagramURLScheme, options: [:], completionHandler: nil)
            }
        }
    }
}



