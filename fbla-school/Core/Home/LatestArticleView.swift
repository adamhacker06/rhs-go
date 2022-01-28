//
//  LatestArticleView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/27/22.
//

import SwiftUI

struct LatestArticleView: View {
    
    @Binding var gigantea: GiganteaModel?
    
    var body: some View {
        
        if let gigantea = gigantea {
            if let firstArticle = gigantea.articles.first {
                Text(firstArticle.title)
            } else {
                Text("No articles")
            }
        }
    }
}

struct LatestArticleView_Previews: PreviewProvider {
    static var previews: some View {
        LatestArticleView(gigantea: .constant(GiganteaModel()))
    }
}
