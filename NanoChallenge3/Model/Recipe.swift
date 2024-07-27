//
//  Item.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import Foundation
import SwiftData
import UIKit

@Model
class Recipe: Identifiable{
    var id: String
    var menuName: String
    var portion: Int
    var portionUnit: String
    var ingredients:[Ingredient]
    var imageData: Data?
    
    init(menuName: String, portion: Int, portionUnit: String, ingredients: [Ingredient], imageData: Data?) {
        id = UUID().uuidString
        self.menuName = menuName
        self.portion = portion
        self.portionUnit = portionUnit
        self.ingredients = ingredients
        self.imageData = imageData
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

