//
//  RecipeBox.swift
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
//  Created by @bytedriver on 4/24/23.
//  
//

import Foundation

class RecipeBox: ObservableObject {
    @Published var allRecipes: [Recipe]
    @Published var collections: [String]
    
    init(recipes: [Recipe]) {
        self.allRecipes = recipes
        self.collections = RecipeBox.collection(from: recipes)
    }
    
    func recipesInCollection(_ collectionName: String?) -> [Recipe] {
        if let name = collectionName {
            return allRecipes.filter { $0.collections.contains(name) }
        } else {
            return []
        }
    }
    
    func favoriteRecipes() -> [Recipe] {
        return allRecipes.filter { $0.isFavorite }
    }
    
    func recentRecipes(age: Int = 30) -> [Recipe] {
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -age, to: Date.now) ?? Date.now
        return allRecipes.filter { $0.addedOnDate > thirtyDaysAgo }
    }
    
    func delete(_ recipe: Recipe) {
        delete(recipe.id)
    }
    
    func delete(_ id: Recipe.ID) {
        if let index = index(for: id) {
            allRecipes.remove(at: index)
            updateCollectionsIfNeeded()
        }
    }
    
    func update(_ recipe: Recipe) {
        if let index = index(for: recipe.id) {
            allRecipes[index] = recipe
            updateCollectionsIfNeeded()
        }
    }
    
    func toggleIsFavorite(_ recipe: Recipe) {
        var recipeToUpdate = recipe
        recipeToUpdate.isFavorite.toggle()
        update(recipeToUpdate)
    }
    
    func index(for id: Recipe.ID) -> Int? {
        allRecipes.firstIndex { $0.id == id }
    }
    
    func recipe(with id: Int) -> Recipe? {
        return allRecipes.first { $0.id == id }
    }
    
    func contains(_ recipe: Recipe) -> Bool {
        contains(recipe.id)
    }
    
    func contains(_ id: Recipe.ID?) -> Bool {
        guard let recipeId = id else { return false }
        return allRecipes.contains { $0.id == recipeId }
    }
}

extension RecipeBox {
    func add(_ recipe: Recipe) -> Recipe.ID {
        var recipeToAdd = recipe
        // Increment the recipe id.
        recipeToAdd.id = (allRecipes.map { $0.id }.max() ?? 0) + 1
        allRecipes.append(recipeToAdd)
        updateCollectionsIfNeeded()
        return recipeToAdd.id
    }
}

extension RecipeBox {
    fileprivate static func collection(from recipes: [Recipe]) -> [String] {
        var allCollections = Set<String>()
        for recipe in recipes {
            allCollections.formUnion(recipe.collections)
        }
        return allCollections.sorted()
    }
    
    fileprivate func updateCollectionsIfNeeded() {
        let updatedCollection = RecipeBox.collection(from: allRecipes)
        if collections != updatedCollection {
            collections = updatedCollection
        }
    }
}
