//
//  ColorPallete.swift
//  brainiacs-ios
//
//  Created by Adam Hacker on 7/13/21.
//

import SwiftUI

// A utility for viewing the color theme
struct ColorPallete: View {
    
    let colors = Color.theme
    
    let grid = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 1/3, maximum: UIScreen.main.bounds.width * 1/3), spacing: 0, alignment: .trailing),
        
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 1/3, maximum: UIScreen.main.bounds.width * 1/3), spacing: 0, alignment: .center),
        
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width * 1/3, maximum: UIScreen.main.bounds.width * 1/3), spacing: 0, alignment: .leading)
    ]
    
    var body: some View {
        ZStack {
            
            Color.gray.ignoresSafeArea()
            
            LazyVGrid(columns: grid) {
                ForEach(colors.asArray.indices) { index in
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(colors.asArray[index])
                            .frame(width: 75, height: 75)
                        
                        Text(colors.asArray[index].description.trimmingCharacters(in: CharacterSet.init(charactersIn: "NamedColor(name:,bundle: nil)")))
                            .font(.callout)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 100)
                }
            }
            .padding()
            .padding(.top)
            .background(
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .shadow(radius: 10)
            
            )
            .padding()
        }
    }
}

struct ColorPallete_Previews: PreviewProvider {
    static var previews: some View {
        ColorPallete()
    }
}
