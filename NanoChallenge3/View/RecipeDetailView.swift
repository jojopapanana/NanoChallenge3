//
//  RecipeDetailView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 16/07/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @State private var navigationPath = NavigationPath() // Add a state variable to manage the navigation path
    
    var body: some View {
        NavigationStack(path: $navigationPath) { // Bind the navigation path to the NavigationStack
            VStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit) // Adjust the aspect ratio as needed
                                .frame(maxWidth: .infinity, maxHeight: 300) // Adjust the frame size as needed
                        } else {
                            Text("No Image Available")
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .frame(height: 30)
                        .padding(.top, 20)
                        
                        Text("Ingredients Recipe")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        
                        ForEach(0..<recipe.ingredients.count, id: \.self) { index in
                            HStack(alignment: .center, spacing: 0) {
                                Text("\(recipe.ingredients[index].ingredientQuantity)")
                                    .font(.body)
                                    .frame(width: 96, alignment: .leading)
                                    .padding(.vertical, 4)
                                    .background(
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(height: 1)
                                            .offset(y: 20) // Move the line down to give space between text and line
                                    )
                                    
                                HStack {
                                    Text(recipe.ingredients[index].ingredientUnit)
                                        .font(.body)
                                        .frame(width: 93, alignment: .leading)
                                        .padding(.vertical, 4)
                                        .background(
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(height: 1)
                                                .offset(y: 20) // Move the line down to give space between text and line
                                        )
                                }
                                
                                HStack {
                                    Text(recipe.ingredients[index].ingredientName)
                                        .font(.body)
                                        .frame(width: 160, alignment: .leading)
                                        .padding(.vertical, 4)
                                        .background(
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(height: 1)
                                                .offset(y: 20) // Move the line down to give space between text and line
                                        )
                                }
                            }
                        }.padding(.bottom, 15)
                
                        Text("Recipe Portion")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        
                        HStack(alignment: .center) {
                            Text("\(recipe.portion)")
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                                .frame(width: 256, height: 47 ,alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                        .opacity(0.6)
                                )
                                .background(.gray.opacity(0.1))
                                .cornerRadius(4)
                            
                            Text("\(recipe.portionUnit)")
                                .font(.body)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                                .frame(width: 93, height: 47 ,alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                        .opacity(0.6)
                                )
                                .background(.gray.opacity(0.1))
                                .cornerRadius(4)
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                }
                
                Spacer()
                
                // Update the NavigationLink to pass data to PortionResultView
                NavigationLink {
                    PortionResultView(
                        recipePortion: recipe.portion,
                        recipePortionUnit: recipe.portionUnit,
                        ingredients: recipe.ingredients,
                        navigationPath: $navigationPath
                    )
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.accentColor) // Ensure the button has a background color

                        Text("Calculate")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 361, height: 46)
                }
            }
            .padding()
            .navigationTitle("Recipe Detail")
        
        NavigationLink{
            PortionResultView(recipePortion: recipe.portion, recipePortionUnit: recipe.portionUnit, recipeSellingPrice: recipe.menuPrice, ingredients: recipe.ingredients, navigationPath: $navigationPath)
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10.0)
                
                Text("Calculate")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 361, height: 60)
            .padding(.top, 20)
        }
        .navigationTitle(recipe.menuName)
    }
}

//#Preview {
//    RecipeDetailView(recipe: Recipe(menuName: "Cookies", portion: 100, portionUnit: "gr", ingredients: [Ingredient(ingredientName: "Sugar", ingredientQuantity: 100, ingredientUnit: "gr")], menuPrice: 10000, imageData: <#T##Data?#>))
//}
