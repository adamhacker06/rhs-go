//
//  ArticleView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/4/21.
//

import SwiftUI

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(article.paragraphContent.indices) { index in
                    Text(article.paragraphContent[index])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.theme.lapiz)
                        .padding(.bottom)
                    
                    
                }
            }
            .padding()
        }
        .navigationTitle(article.title)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article(title: "This is a test article", author: "Adam Hacker", publishedDate: Date(), category: "Arts and Entertainment", htmlContent: "", paragraphContent: [""]))
    }
}
