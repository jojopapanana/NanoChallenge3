//
//  AllRecipeView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 25/07/24.
//

import SwiftUI
import SwiftData

struct AllRecipeView: View {
    @Query private var recipes: [Recipe]
    @Binding var navigationPath: NavigationPath
    @State private var searchTerm = ""

    var filteredRecipe: [Recipe] {
        guard !searchTerm.isEmpty else { return recipes }
        return recipes.filter { $0.menuName.localizedCaseInsensitiveContains(searchTerm) }
    }

    var body: some View {
        ScrollView {
            if recipes.isEmpty {
                recipeCardEmpty()
            } else {
                VStack(spacing: 18) {
                    ForEach(0..<filteredRecipe.count / 2, id: \.self) { rowIndex in
                        HStack(spacing: -4) {
                            ForEach(0..<2, id: \.self) { columnIndex in
                                let cardIndex = rowIndex * 2 + columnIndex
                                if cardIndex < filteredRecipe.count {
                                    NavigationLink {
                                        RecipeDetailView(recipe: filteredRecipe[filteredRecipe.count - cardIndex - 1], navigationPath: $navigationPath)
                                    } label: {
                                        RecipeCardView(recipe: filteredRecipe[filteredRecipe.count - cardIndex - 1])
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top, 20)
            }
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Menu")}
}

//#Preview {
//    AllRecipeView()
//}


