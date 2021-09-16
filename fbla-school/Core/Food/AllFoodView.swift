//
//  AllFoodView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/6/21.
//

import SwiftUI

struct AllFoodView: View {
    
    @EnvironmentObject var data: DataManager
    
    @State private var foods = [Food]()
    // @State private var isInit = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ForEach(foods.indices, id: \.self) { index in
                
                FoodTileView(food: foods[index])
                
            }
        }
        .onAppear {
            data.database.fetch { (returnedFoods, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let returnedFoods = returnedFoods {
                    foods = returnedFoods
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
