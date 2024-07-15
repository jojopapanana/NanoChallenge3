//
//  Item.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import Foundation
import SwiftData

@Model
class Menuu: Identifiable{
    var id: String
    var menuName: String
    var portion: Int
    var portionUnit: String
//    let ingredients = Ingredient(ingredientName: "ingredient", ingredientQuantity: 1, ingredientUnit: "kg")
    var menuPrice: Int
    init(menuName: String, portion: Int, portionUnit: String, ingredients: Ingredient, menuPrice: Int) {
        id = UUID().uuidString
        self.menuName = menuName
        self.portion = portion
        self.portionUnit = portionUnit
//        self.ingredients = ingredients
        self.menuPrice = menuPrice
    }
}

@Model
class ImageAttribute {
    var id: UUID
    @Attribute(.externalStorage) var image: Data?
    
    init() {
        self.id = UUID()
        
    }
}

