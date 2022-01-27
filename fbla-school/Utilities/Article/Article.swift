//
//  Article.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/1/21.
//

import Foundation

struct Article: Hashable {
    var title = ""
    var author = ""
    var publishedDate = Date()
    var category = ""
    var htmlContent = ""
    
    var paragraphContent: [String] = []
}
