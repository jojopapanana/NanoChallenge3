//
//  AllRecipeView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 25/07/24.
//

import SwiftUI
import SwiftData

struct AllRecipeView: View {
    @Query private var recipes:[Recipe]
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
        ScrollView{
            if recipes.isEmpty {
                recipeCardEmpty()
            } else {
                VStack(spacing: 18){
                    ForEach(0..<recipes.count / 2, id: \.self) { rowIndex in
                        HStack(spacing: -4) {
                            ForEach(0..<2, id: \.self) { columnIndex in
                                let cardIndex = rowIndex * 2 + columnIndex
                                if cardIndex < recipes.count {
                                    NavigationLink{
                                        RecipeDetailView(recipe: recipes[recipes.count - cardIndex - 1], navigationPath: $navigationPath)
                                    } label: {
                                        RecipeCardView(recipe: recipes[recipes.count - cardIndex - 1])
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top, 20)
            }
        }
    }
}

//#Preview {
//    AllRecipeView()
//}
