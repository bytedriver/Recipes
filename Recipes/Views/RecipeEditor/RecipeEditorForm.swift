//
//  RecipeEditorForm.swift
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
//  Created by @bytedriver on 4/28/23.
//  
//

import SwiftUI

struct RecipeEditorForm: View {
    @Binding var config: RecipeEditorConfig
    
    var body: some View {
        Form {
            TextField("Recipe name", text: $config.recipe.title)
            Section {
                TextField(text: $config.recipe.servings, prompt: Text("4-6")) {
                    Text("Servings")
                }
                TextField(text: $config.recipe.prepTimeAsText, prompt: Text("in seconds")) {
                    Text("Prep time")
                }
                TextField(text: $config.recipe.cookTimeAsText, prompt: Text("in seconds")) {
                    Text("Cook time")
                }
                TextField(text: $config.recipe.collectionAsText, prompt: Text("Breakfast, Lunch, Dinner")) {
                    Text("Collections")
                }
            }
            Section("Ingredients") {
                TextEditor(text: $config.recipe.ingredients)
            }
            Section("Directions") {
                TextEditor(text: $config.recipe.directions)
            }
        }
    }
}

struct RecipeEditorForm_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorForm(config: .constant(RecipeEditorConfig()))
    }
}
