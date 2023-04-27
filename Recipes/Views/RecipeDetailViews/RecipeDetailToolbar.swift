//
//  RecipeDetailToolbar.swift
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

struct RecipeDetailToolbar: ToolbarContent {
    @Binding var recipe: Recipe
    @Binding var showDeleteConfirmation: Bool
    let deleteRecipe: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                withAnimation {
                    recipe.isFavorite.toggle()
                }
            } label: {
                Image(systemName: "heart")
                    .symbolVariant(recipe.isFavorite ? .fill : .none)
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(role: .destructive) {
                showDeleteConfirmation = true
            } label: {
                Image(systemName: "trash")
            }
            .alert("Delete Recipe?", isPresented: $showDeleteConfirmation) {
                Button(role: .destructive) {
                    withAnimation {
                        deleteRecipe()
                    }
                } label: {
                    Text("Delete \(recipe.title)")
                }

            }
        }
    }
}
