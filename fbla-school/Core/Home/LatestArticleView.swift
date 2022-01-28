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
        Group {
            if let gigantea = gigantea {
                if let firstArticle = gigantea.articles.first {
                    VStack(spacing: 20) {
                        HStack {
                            Text("🗞")
                                .font(.system(size: 30))
                                .padding(5)
                                .background(Color.theme.darkRed)
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("The Latest and Greatest")
                                    .font(.custom("PublicSans-SemiBold", size: 24))
                                    .foregroundColor(Color.theme.white)
                                    
                                Text("From the Redwood Gigantea")
                                    .font(.custom("PublicSans-Regular", size: 18))
                                    .foregroundColor(Color.theme.white)
                            }
                        }
                        
                        Text(firstArticle.title)
                            .foregroundColor(Color.theme.white)
                        
                    }
                    .padding(20)
                    
                } else {
                    Text("No articles")
                }
            }
        }
        .background(Color.theme.candyPurple)
        
    }
}

struct LatestArticleView_Previews: PreviewProvider {
    static var previews: some View {
        LatestArticleView(gigantea: .constant(GiganteaModel()))
    }
}
