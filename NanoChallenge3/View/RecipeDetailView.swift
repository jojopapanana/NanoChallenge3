//
//  RecipeDetailView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 16/07/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe:Recipe
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Ingredients Recipe")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                        ForEach(0..<recipe.ingredients.count, id: \.self) { index in
                            HStack{
                                HStack{
                                    Text("\(recipe.ingredients[index].ingredientQuantity)")
                                }
                                .padding()
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                        .opacity(0.6)
                                )
                                
                                HStack{
                                    Text(recipe.ingredients[index].ingredientUnit)
                                }
                                .padding()
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                        .opacity(0.6)
                                )
                                
                                HStack{
                                    Text(recipe.ingredients[index].ingredientName)
                                }
                                .padding()
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                        .opacity(0.6)
                                )
                                
                                Spacer()
                            }
                                
                        }
                    
                    Text("Recipe Portion")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    HStack{
                        Text("\(recipe.portion)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: 100, alignment: .leading)
                        
                        Text("\(recipe.portionUnit)")
                            .font(.title)
                            .frame(width: 80)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Text("Selling Price")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    HStack{
                        Text("Rp")
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        Text(
                            "\(recipe.menuPrice)"
                        )
                        .font(.title3)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                }
            }
            .padding()
//            .padding(.leading, -120)
        }
        .navigationTitle("Recipe Detail")
    }
}

//#Preview {
//    RecipeDetailView()
//}
