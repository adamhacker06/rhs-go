//
//  AddToInstagramStory.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI

class TwitterManager {
    
    static func openTwitterProfile(handle: String) {
        let appURL = NSURL(string: "twitter://user?screen_name=\(handle)")!
        let webURL = NSURL(string: "https://twitter.com/\(handle)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
        
//        let tweetText = "hello!"
//        let tweetURL = "https://www.brainiacsmentoring.com"
//
//        let shareString = "https://twitter.com/intent/tweet?text=\(tweetText)&url=\(tweetURL)"
//
//        // encode a space to %20 for example
//        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//
//        // cast to an url
//        let url = URL(string: escapedShareString)
//
//        // open in safari
//        UIApplication.shared.open(url!)
    }
    
}

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
    
    static func openInstagramProfile(handle: String) {
        
        let instagramURL = URL(string: "instagram://user?username=\(handle)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(instagramURL) {
            application.open(instagramURL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            let webURL = URL(string: "https://instagram.com/\(handle)")!
            application.open(webURL)
        }
        
    }
}



