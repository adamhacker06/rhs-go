//
//  FoodTileView.swift
//  Redwood HS Helper
//
//  Created by Adam Hacker on 9/7/21.
//

import SwiftUI

struct FoodTileView: View {
    
    let food: Food
    
    var body: some View {
        NavigationLink(
            destination: FoodInfoView(food: food),
            label: {
                TileBody
            })
    }
}

extension FoodTileView {
    private var TileBody: some View {
        VStack {
            Text(food.name!)
            Text(food.portion ?? "Unknown")
        }
    }
}

struct FoodTileView_Previews: PreviewProvider {
    static var previews: some View {
        FoodTileView(food: Development.chickenSandwich)
    }
}
