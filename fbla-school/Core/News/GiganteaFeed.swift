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
    @Environment(\.presentationMode) var presentationMode
    
    //    @State private var articleStore: [Article]
    
    @State private var showArticle: Bool = false
    @State private var targetArticle: Article = Article()
    
    //    var url: URL
    //    var artdata: Data
    
    var body: some View {
        ZStack {
            
            NavigationLink("", isActive: $showArticle) {
                ArticleView(article: targetArticle)
                    .navigationTitle("Article")
                    .navigationBarTitleDisplayMode(.inline)
                
            }
            
            Color.theme.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerComponents
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        if let gigantea = data.giganteaDataManager.gigantea {
                            
                            ForEach(gigantea.articles, id: \.self) { article in
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    // Category
                                    Text(article.category)
                                        .foregroundColor(.theme.purple)
                                        .font(.custom("PublicSans-Bold", size: 24))
                                        .padding(.bottom, 5)
                                    
                                    // Divider
                                    CustomDivider(color: .theme.purple, thickness: 2)
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
                                .background(
                                    
                                    RoundedRectangle(cornerRadius: 15)
                                        .strokeBorder(Color.theme.purple, lineWidth: 1)
                                        .background(Color.white.cornerRadius(15))
                                )
                                .onTapGesture {
                                    targetArticle = article
                                    showArticle = true
                                }
                                
                            }
                        } else {
                            Text("unable to load articles")
                        }
                        
                        
                    }
                    .padding(20)
                }
            }
        }
    }
}

extension GiganteaFeed {
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("Redwood Gigantea")
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.purple.ignoresSafeArea()
                .shadow(radius: 5)
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
