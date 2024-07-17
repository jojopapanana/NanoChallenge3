//
//  InputRecipeViewModel.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import Foundation
import SwiftData
import UIKit

class InputRecipeViewModel: ObservableObject{
    @Published var menuName: String = ""
    @Published var portion: Int = 0
    @Published var portionUnit: String = ""
    @Published var menuPrice: Int = 0
    @Published var imageData:Data?
    @Published var ingredientList = [Ingredient]()
    
    func saveRecipe(context: ModelContext){
        let recipe = Recipe(menuName: menuName, portion: portion, portionUnit: portionUnit, ingredients: ingredientList, menuPrice: menuPrice, imageData: imageData)
        context.insert(recipe)
        print("save success")
        if let imageData{
            print("ada imagedatanya")
        } else {
            print("kosong gambarnya")
        }
//        print(recipe.imageData?.isEmpty)
//        print(recipe.portion)
    }
}
