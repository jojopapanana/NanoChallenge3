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
    
    var body: some View {
        NavigationStack {
            VStack {
                if recipes.isEmpty {
                    recipeCardEmpty()
                } else {
                    TabView {
                        ForEach(recipes.reversed()){recipe in
                            VStack(alignment: .leading){
                                Text(recipe.menuName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top, 20)
                                
                                Text("\(recipe.portion) \(recipe.portionUnit)")
                                    .font(.title2)
                                    .fontWeight(.light)
                                
                                ForEach(recipe.ingredients, id:\.self){ingredient in
                                    if (ingredient.hashValue <= 3){
                                        HStack{
                                            HStack{
                                                Text("\(ingredient.ingredientQuantity)")
                                            }
                                            .padding()
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                    .inset(by: 0.5)
                                                    .stroke(.gray, lineWidth: 1)
                                                    .opacity(0.6)
                                            )
                                            
                                            HStack{
                                                Text(ingredient.ingredientUnit)
                                            }
                                            .padding()
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                    .inset(by: 0.5)
                                                    .stroke(.gray, lineWidth: 1)
                                                    .opacity(0.6)
                                            )
                                            
                                            HStack{
                                                Text(ingredient.ingredientName)
                                            }
                                            .padding()
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                    .inset(by: 0.5)
                                                    .stroke(.gray, lineWidth: 1)
                                                    .opacity(0.6)
                                            )
                                        }
                                        .padding(.top, 20)
                                    }
                                }
                                
                                HStack(alignment: .center, spacing: 12){
                                    NavigationLink{
                                        //To converter view
                                    } label: {
                                        VStack{
                                            HStack{
                                                Image(systemName: "scalemass.fill")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.button)
                                            }
                                            .frame(width: 30)
                                            .padding()
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                    .inset(by: 0.5)
                                                    .stroke(.button, lineWidth: 1)
                                                    .opacity(0.6)
                                            )
                                        }
                                        .padding(.top, 20)
                                    }
                                    
                                    NavigationLink{
                                        RecipeDetailView(recipe: recipe)
                                    } label: {
                                        VStack{
                                            HStack{
                                                Text("View Recipe")
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.button)
                                            }
                                            .frame(width: 220)
                                            .padding()
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                    .inset(by: 0.5)
                                                    .stroke(.button, lineWidth: 1)
                                                    .opacity(0.6)
                                            )
                                        }
                                        .padding(.top, 20)
                                    }
                                }
                                .padding()
                                .frame(width: 312)
                            }
                            .padding()
                            .frame(width: 344, height: 446, alignment: .leading)
                            .background(.recipeBackground)
                            .cornerRadius(20)
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                }

                Spacer()

                NavigationLink {
                    ChooseInputView()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.button)
                        
                        HStack{
                            Image(systemName: "plus.square")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("Insert Recipe")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                        .foregroundStyle(Color.white)
                    }
                    .padding()
                    .frame(width: 361, height: 100)
                }
            }
            .navigationTitle("Recipes")
//            .padding(.top, 10)
        }
    }
}

#Preview {
    RecipeView()
}
