//
//  Recipe.swift
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

import SwiftUI

struct Recipe: Identifiable, Codable {
    var id: Int
    var title: String
    var rating: Int
    var prepTime: Int   // In seconds.
    var cookTime: Int   // In seconds.
    var servings: String
    var directions: String
    var isFavorite: Bool
    var collections: [String]
    fileprivate var addedOn: Date? = Date.now
    fileprivate var imageNames: [String]
}

extension Recipe {
    var addedOnDate: Date {
        addedOn ?? Date.now
    }
    
    var subtitle: String {
        var subtitle = "\(self.servings) servings | "
        
        let now = Date.now
        let later = now + TimeInterval(prepTime + cookTime)
        subtitle += (now..<later).formatted(.components(style: .condensedAbbreviated))
        
        return subtitle
    }
    
    var thumbnailImage: Image {
        let name = imageNames.last ?? "placeholder"
        return ImageStore.shared.image(name: name)
    }
    var smallImage: Image {
        guard imageNames.count >= 2 else { return thumbnailImage }
        
        let name = imageNames[1]
        return ImageStore.shared.image(name: name)
    }
    
    var fullImage: Image {
        let name = imageNames.first ?? "placeholder"
        return ImageStore.shared.image(name: name)
    }
    
    private static let newRecipeId: Recipe.ID = -1
    var isNew: Bool {
        id == Recipe.newRecipeId
    }
}

extension Recipe {
    static func emptyRecipe() -> Recipe {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")

        let json = """
            {
                "id": \(Recipe.newRecipeId),
                "title": "",
                "rating": 0,
                "prepTime": 0,
                "cookTime": 0,
                "servings": "",
                "ingredients": "",
                "directions": "",
                "isFavorite": false,
                "collections": [],
                "imageNames": []
            }
        """
        let data = Data(json.utf8)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Recipe.self, from: data)
        } catch {
            fatalError("Invalid recipe JSON")
        }
    }
}
