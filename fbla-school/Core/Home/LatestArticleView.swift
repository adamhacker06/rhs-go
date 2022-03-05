//
//  LatestArticleView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 1/27/22.
//

import SwiftUI

struct LatestArticleView: View {
    
    @Binding var gigantea: GiganteaModel?
    
    @State private var showAllArticles: Bool = false
    
    var body: some View {
        VStack {
            
            if let gigantea = gigantea {
                if let firstArticle = gigantea.articles.first {
                    VStack(spacing: 20) {
                        HStack {
//                            Text("🗞")
//                                .font(.system(size: 30))
//                                .padding(5)
//                                .background(Color.theme.lapiz)
//                                .cornerRadius(10)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                
                                Text("The Latest and Greatest")
                                    .font(.custom("PublicSans-SemiBold", size: 18))
                                    .foregroundColor(Color.theme.white)
                                    
                                Text("From the Redwood Gigantea")
                                    .font(.custom("PublicSans-Regular", size: 16))
                                    .foregroundColor(Color.theme.white)
                                
                            }
                            
                            Spacer()
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(firstArticle.title)
                                .font(.custom("PublicSans-Medium", size: 20))
                            
                            Text("By " + firstArticle.author)
                                .font(.custom("PublicSans-Regular", size: 17))
                        }
                        .foregroundColor(Color.white)
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.theme.lightPurple.cornerRadius(5))
                        
                        Button(action: { showAllArticles = true } ) {
                            Text("Read more")
                                .underline()
                                .foregroundColor(.white)
                                .font(.custom("PublicSans-Regular", size: 16))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                    }
                    .padding(20)
                    
                } else {
                    Text("No articles")
                }
            }
        }
        .background(
            ZStack {
                NavigationLink("", isActive: $showAllArticles) {
                    GiganteaFeed()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
                
                Color.theme.purple
            }
        )
    }
}

struct LatestArticleView_Previews: PreviewProvider {
    static var previews: some View {
        LatestArticleView(gigantea: .constant(GiganteaModel()))
    }
}
