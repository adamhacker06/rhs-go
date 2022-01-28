//
//  GiganteaFeed.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/1/21.
//

import SwiftUI

extension String {
    func asXMLDatafromString() -> Data {
        return Data(
            ("<?xml version=\"1.0\" encoding=\"UTF-8\"?> <content>" + self + "</content>")
                .replacingOccurrences(of: "<br>", with: "")
                .replacingOccurrences(of: "&nbsp;", with: "")
                .utf8)
    }
}

struct GiganteaFeed: View {
    
    @EnvironmentObject var data: DataManager
    
//    @State private var articleStore: [Article]
    
    @State private var showArticle: Bool = false
    @State private var targetArticle: Article = Article()
    
//    var url: URL
//    var artdata: Data
    
    var body: some View {
        ZStack {
            Color.theme.candyPurple.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    
//                    NavigationLink(destination: EmptyView()) {
//                        EmptyView()
//                            .navigationTitle("")
//                            .navigationBarHidden(true)
//                    }
                    
                    NavigationLink(
                        "",
                        isActive: $showArticle) {
                            ArticleView(article: targetArticle)
                                .navigationTitle("Article")
                                .navigationBarTitleDisplayMode(.inline)
                            
                        }
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        Text("The Redwood Gigantea")
                            .font(.custom("PublicSans-SemiBold", size: 25))
                            .foregroundColor(.white)
                            //.frame(maxWidth: .infinity, alignment: .leading)
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .padding(.top, 3)
                            .frame(maxWidth: 100, maxHeight: 5)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    if let gigantea = data.giganteaDataManager.gigantea {
                        
                        ForEach(gigantea.articles, id: \.self) { article in
                            
                            VStack(alignment: .leading, spacing: 0) {
                                
                                // Category
                                Text(article.category)
                                    .foregroundColor(.theme.lapiz)
                                    .font(.custom("PublicSans-Bold", size: 24))
                                    .padding(.bottom, 10)
                                
                                // Divider
                                CustomDivider(color: .theme.lapiz, thickness: 2)
                                    .padding(.bottom, 10)
                                
                                // Title
                                Text(article.title)
                                    .foregroundColor(.theme.purple)
                                    .font(.custom("PublicSans-SemiBold", size: 16))
                                    .padding(.bottom, 5)
                                
                                // Author
                                Text("by \(article.author)")
                                    .foregroundColor(.theme.lightPurple)
                                    .font(.custom("PublicSans-Regular", size: 14))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.white.ignoresSafeArea().cornerRadius(15))
                            .onTapGesture {
                                targetArticle = article
                                showArticle = true
                            }
                            
                        }
                    } else {
                        Text("unable to load articles")
                    }
                    
                    
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct GiganteaFeed_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GiganteaFeed()
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}
