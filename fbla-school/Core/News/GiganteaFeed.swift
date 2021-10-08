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
    
    @StateObject var gigantea = GiganteaFeedViewModel()
    
    @State private var articleStore: [Article] = []
    
    var url: URL
    var data: Data

    init() {
        
        self.url = URL(string: "https://redwoodgigantea.com/feed/")!
        self.data = try! Data(contentsOf: url)
        
        self.articleStore = []
        
        let parser = ArticlesParser(data: data)
        
        if parser.parse() {
            
            for i in parser.articles.indices {
                
                let paragraphsParser = HTMLasXMLContentParser(data: parser.articles[i].htmlContent.asXMLDatafromString())
                
                if paragraphsParser.parse() {
                    parser.articles[i].paragraphContent = paragraphsParser.paragraphs
                }
                
                articleStore.append(parser.articles[i])
                
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.theme.candyPurple.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
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
                    
                    ForEach(gigantea.articles.indices) { index in
                        NavigationLink(
                            destination:
                                ArticleView(article: gigantea.articles[index])
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarTitleDisplayMode(.inline),
                            
                            label: {
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    // Category
                                    Text(gigantea.articles[index].category)
                                        .foregroundColor(.theme.lapiz)
                                        .font(.custom("PublicSans-Bold", size: 24))
                                        .padding(.bottom, 10)
                                    
                                    // Divider
                                    CustomDivider(color: .theme.lapiz, thickness: 2)
                                        .padding(.bottom, 10)
                                    
                                    // Title
                                    Text(gigantea.articles[index].title)
                                        .foregroundColor(.theme.purple)
                                        .font(.custom("PublicSans-SemiBold", size: 16))
                                        .padding(.bottom, 5)
                                    
                                    // Author
                                    Text("by \(gigantea.articles[index].author)")
                                        .foregroundColor(.theme.lightPurple)
                                        .font(.custom("PublicSans-Regular", size: 14))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.white.ignoresSafeArea().cornerRadius(15))
                                
                            })
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            gigantea.articles = articleStore
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
