//
//  AllFoodView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/6/21.
//

import SwiftUI

struct AllFoodView: View {
    
    @EnvironmentObject var data: DataManager
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ForEach(data.foodDataManager.foods?.indices ?? [].indices, id: \.self) { index in
                
                FoodTileView(food: data.foodDataManager.foods![index])
                
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
