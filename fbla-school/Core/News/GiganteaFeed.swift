//
//  GiganteaFeed.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/1/21.
//

import SwiftUI

struct GiganteaFeed: View {
    
    @ObservedObject var gigantea = GiganteaFeedViewModel()
    @State var isLoadingArticles = true
    
    var body: some View {
        ZStack {
            Color.theme.lapiz.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    
                    if isLoadingArticles {
                        ProgressView()
                    } else {
                        
                        ForEach(gigantea.articles.indices) { index in
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
                        }
                    }
                }
                .onAppear {
                    
                    let url = URL(string: "https://redwoodgigantea.com/feed/")
                    let data = try! Data(contentsOf: url!)
                    let parser = ArticlesParser(data: data)
                    
                    if parser.parse() {
                        
                        isLoadingArticles = false
                        gigantea.articles = parser.articles
                        
                    }
                }
            }
        }
    }
}

struct GiganteaFeed_Previews: PreviewProvider {
    static var previews: some View {
        GiganteaFeed()
    }
}
