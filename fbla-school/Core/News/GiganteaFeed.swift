//
//  GiganteaFeed.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/1/21.
//

import SwiftUI

//struct ArticleView: View {
//
//    let string: String
//
//    var body: some View {
//        HTMLView(htmlString: string)
//            .onAppear() {
//                print(string)
//            }
//    }
//}

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
    
    @ObservedObject var gigantea = GiganteaFeedViewModel()
    
    var url: URL
    var data: Data

    init() {
        
        self.url = URL(string: "https://redwoodgigantea.com/feed/")!
        self.data = try! Data(contentsOf: url)
        let parser = ArticlesParser(data: data)
        
        if parser.parse() {
            
            for i in parser.articles.indices {
                
                let paragraphsParser = HTMLasXMLContentParser(data: parser.articles[i].htmlContent.asXMLDatafromString())
                
                if paragraphsParser.parse() {
                    parser.articles[i].paragraphContent = paragraphsParser.paragraphs
                }
                
                gigantea.articles.append(parser.articles[i])
                
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.theme.lapiz.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    
                    Button("Debug") {
                        print(gigantea.articles[2].paragraphContent)
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    
                    ForEach(gigantea.articles.indices) { index in
                        NavigationLink(
                            destination:
                                ArticleView(article: gigantea.articles[index])
                                .navigationBarTitleDisplayMode(.inline),
                            
                            label: {
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    Text(gigantea.articles[index].category)
                                        .foregroundColor(.theme.lapiz)
                                        .font(.title2)
                                        .bold()
                                        .padding(.bottom, 10)
                                    
                                    CustomDivider(color: .theme.lapiz, thickness: 2)
                                        .padding(.bottom, 10)
                                    
                                    Text(gigantea.articles[index].title)
                                        .foregroundColor(.theme.lapiz)
                                        .bold()
                                        .padding(.bottom, 3)
                                    
                                    Text("by \(gigantea.articles[index].author)")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.theme.lightBlue.ignoresSafeArea().cornerRadius(15))
                                .padding(.horizontal, 20)
                            })
                    }
                }
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
