//
//  RecipeView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    @Query private var recipes:[Recipe]
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath){
            HStack(spacing: 8){
                Image("logowisecookforhome")
                    .resizable()
                    .frame(width: 35.25, height: 36.8, alignment: .leading)
                
                Image("wisecooktitle")
                    .resizable()
                    .frame(width: 85.96, height: 13.53)
                
                Spacer()
            }
            .padding()
            
            HStack{
                Text("Recent Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                
            }
            .padding(.leading)
            
            HStack{
                Text("Recipes that you have made")
                    .foregroundStyle(Color.gray)
                Spacer()
                
                NavigationLink{
                    AllRecipeView(navigationPath: $navigationPath)
                } label: {
                    HStack {
                        Text("View all")
                        Image(systemName: "chevron.right")
                    }
                    .padding(.trailing)
                }
            }
            .padding(.leading)
            
            VStack{
                if recipes.isEmpty {
                    recipeCardEmpty()
                } else {
                    VStack(spacing: 18){
                        ForEach(0..<2, id: \.self) { rowIndex in
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
            
            HStack(spacing: -4){
                NavigationLink(value: "ManualView") {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.button)
                        
                        HStack{
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("Manual")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                        .foregroundStyle(Color.white)
                    }
                    .padding()
                    .frame(width: 200, height: 100)
                }
                
                NavigationLink(value: "ScanningView") {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.button)
                        
                        HStack{
                            Image(systemName: "camera.fill")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("Scan")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                        .foregroundStyle(Color.white)
                    }
                    .padding()
                    .frame(width: 200, height: 100)
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "ManualView" {
                    InputRecipeView(navigationPath: $navigationPath)
                } else if value == "ScanningView"{
                    ScanInstructions(navigationPath: $navigationPath)
                }
            }
        }
    }
}

#Preview {
    RecipeView()
}
