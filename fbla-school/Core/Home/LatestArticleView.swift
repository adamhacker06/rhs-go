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
            
            VStack(spacing: 0) {
                
                // header
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading, spacing: 2) {
                        
                        Text("The Latest and Greatest")
                            .font(.publicSans, weight: .medium, size: 18)
                            .foregroundColor(Color.theme.white)
                            
                        Text("From the Redwood Gigantea")
                            .font(.custom("PublicSans-Regular", size: 16))
                            .foregroundColor(Color.theme.white)
                        
                    }
                    
                    Spacer()
                    
                    if let gigantea = gigantea {
                        if gigantea.articles.count > 1 {
                            Button(action: { showAllArticles = true } ) {
                                Text("Read more")
                                    .font(.custom("PublicSans-Regular", size: 16))
                                    .foregroundColor(.white)
                                    .underline()

                            }
                        }
                    }

                }
                .padding()
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
                
                if let gigantea = gigantea {
                    if let firstArticle = gigantea.articles.first {
                        // body
                        VStack(alignment: .leading, spacing: 3) {
                            Text(firstArticle.title)
                                .font(.publicSans, weight: .medium, size: 16)
                            
                            Text("By " + firstArticle.author)
                                .font(.publicSans, weight: .regular, size: 14)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(Color.theme.lightPurple.cornerRadius(5))
                        .padding()
                        
                        .background(Color.white)
                        
                    }
//                    else {
//                        Text("Unable to load articles")
//                            .font(.publicSans, weight: .regular, size: 16)
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            .padding()
//                            .background(Color.white)
//                    }
//
                }
//                else {
//                    Text("Unable to load articles")
//                        .font(.publicSans, weight: .regular, size: 16)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .padding()
//                        .background(Color.white)
//                }
                
            }
            .cornerRadius(10)
            .shadow(radius: 5)
            
        }
    }
}

struct LatestArticleView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            Color.init(hex: 0xf5f5f5).ignoresSafeArea()
            
            LatestArticleView(gigantea: .constant(Development.gigantea))
                .padding(.horizontal, 20)
            
        }
    }
}
