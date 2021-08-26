//
//  AddToInstagramStory.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 8/25/21.
//

import SwiftUI

func shareToInstagram() {
    if let instagramURLScheme = URL(string: "instagram-stories://share") {
        
        if UIApplication.shared.canOpenURL(instagramURLScheme) {
            
            let image: Data = UIImage(imageLiteralResourceName: "rhs_blue").pngData()!
            
            let items = [["com.instagram.sharedSticker.backgroundImage" : image]]
            let pasteboardConfig = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(150)]
            
            UIPasteboard.general.setItems(items, options: pasteboardConfig)
            
            UIApplication.shared.open(instagramURLScheme, options: [:], completionHandler: nil)
        }
    }
}

