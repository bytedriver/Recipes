//
//  RecipeDetailView.swift
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
//  Created by @bytedriver on 4/27/23.
//  
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        VStack {
            TopView(recipe: $recipe)
            ScrollView {
                BottomView(recipe: recipe)
            }
        }
    }
}

private struct TopView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Binding var recipe: Recipe
    
    private var frameHeight: CGFloat {
        verticalSizeClass == .compact ? 150.0 : 300.0
    }
    
    var body: some View {
        TitleView(recipe: $recipe)
            .frame(height: frameHeight, alignment: .bottom)
            .background(alignment: .bottom) {
                recipe.fullImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .clipped()
    }
}

private struct BottomView: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            RecipeIngredientsView(recipe: recipe)
            RecipeDirectionsView(recipe: recipe)
        }
        .padding()
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var recipeBox = RecipeBox()
    
    static var previews: some View {
        RecipeDetailView(recipe: .constant(recipeBox.allRecipes[0]))
    }
}
