//
//  RecipeListItemView.swift
//  Recipes
//
//  88                                                     88              88                                     
//  88                          ,d                         88              ""                                     
//  88                          88                         88                                                     
//  88,dPPYba,   8b       d8  MM88MMM  ,adPPYba,   ,adPPYb,88  8b,dPPYba,  88  8b       d8   ,adPPYba,  8b,dPPYba,
//  88P'    "8a  `8b     d8'    88    a8P_____88  a8"    `Y88  88P'   "Y8  88  `8b     d8'  a8P_____88  88P'   "Y8
//  88       d8   `8b   d8'     88    8PP"""""""  8b       88  88          88   `8b   d8'   8PP"""""""  88        
//  88b,   ,a8"    `8b,d8'      88,   "8b,   ,aa  "8a,   ,d88  88          88    `8b,d8'    "8b,   ,aa  88        
//  8Y"Ybbd8"'       Y88'       "Y888  `"Ybbd8"'   `"8bbdP"Y8  88          88      "8"       `"Ybbd8"'  88        
//                   d8'                                                                                          
//                  d8'                 THE WORLD'S FIRST BYTE DNA ARCHITECT                                      
//
//  Created by @bytedriver on 4/25/23.
//  
//

import SwiftUI

struct RecipeListItemView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            recipe.smallImage
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(4)

            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.title3)
                Text(recipe.subtitle)
                    .font(.caption)
            }
            
            Spacer()
            
            if recipe.isFavorite {
                Image(systemName: "heart")
                    .symbolVariant(.fill)
            }
        }
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    static let recipeBox = RecipeBox()
    
    static var previews: some View {
        RecipeListItemView(recipe: recipeBox.allRecipes[0])
    }
}
