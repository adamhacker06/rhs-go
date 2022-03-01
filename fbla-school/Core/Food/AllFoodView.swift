//
//  AllFoodView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/6/21.
//

import SwiftUI

struct AllFoodView: View {
    
    @EnvironmentObject var data: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    private var gridItemLayout = [GridItem(.fixed(150)), GridItem(.fixed(150))]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            headerComponents
            
            VStack(spacing: 0) {
                entreeSection
                
                Spacer()
            }
            .background(Color.white)
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

extension AllFoodView {
    
    private var headerComponents: some View {
        HStack {
            
            Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
            
            Text("All Foods")
                .font(.custom("PublicSans-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
            
        }
        .padding()
        .background {
            Color.theme.orange.ignoresSafeArea()
                .shadow(radius: 5)
        }
    }
    
    private var entreeSection: some View {
        VStack(spacing: 0) {
            
            VStack(spacing: 0) {
                Text("Entrees")
                    .font(.custom("PublicSans-Medium", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                
            ScrollView(.horizontal, showsIndicators: false) {
                    
                LazyHGrid(rows: gridItemLayout, spacing: 10) {
                        ForEach(data.foodDataManager.foods?.indices ?? [].indices, id: \.self) { index in
                            
                            FoodTileView(food: data.foodDataManager.foods![index])
                                .frame(width: 300, height: 150)
                            
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}

struct AllFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AllFoodView()
            .environmentObject(DataManager())
    }
}
