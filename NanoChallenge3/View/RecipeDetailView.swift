//
//  RecipeDetailView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 16/07/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe:Recipe
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
            ScrollView{
                VStack(alignment: .leading){
                    Text(recipe.menuName)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 361, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Text("No image available")
                    }
                    
                    Text("Recipe ingredients")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    Text("Composition needed to fulfill your target")
                        .font(.body)
                        .foregroundStyle(.gray)
                    
                    VStack(alignment: .leading){
                        GeometryReader { geometry in
                                let totalWidth = geometry.size.width
                                let firstWidth = totalWidth * 1 / 5
                                let secondWidth = totalWidth * 1 / 5
                            let thirdWidth = totalWidth * 2.75 / 5

                            HStack {
                                    Text("qty")
                                        .fontWeight(.semibold)
                                        .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                        .frame(width: firstWidth, alignment: .leading)

                                    Text("unit")
                                        .fontWeight(.semibold)
                                        .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                        .frame(width: secondWidth, alignment: .leading)

                                    Text("ingredient")
                                    .fontWeight(.semibold)
                                        .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                        .frame(width: thirdWidth, alignment: .leading)
//                                        .layoutPriority(1)
                            }
                            .frame(width: totalWidth, alignment: .leading)
                        }
                        .frame(height: 30)
                        .padding(.top, 20)
                        
                        Divider()
                        
                        ForEach(0..<recipe.ingredients.count, id: \.self) { index in
                                GeometryReader { geometry in
                                        let totalWidth = geometry.size.width
                                        let firstWidth = totalWidth * 1 / 5
                                        let secondWidth = totalWidth * 1 / 5
                                    let thirdWidth = totalWidth * 2.75 / 5

                                    HStack {
                                            Text(recipe.ingredients[index].ingredientQuantity, format: .number.precision(.fractionLength(2)))
                                                .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                                .frame(width: firstWidth, alignment: .leading)
                                                .fixedSize(horizontal: false, vertical: true)

                                            Text(recipe.ingredients[index].ingredientUnit)
                                                .lineLimit(1)
                                                .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                                .frame(width: secondWidth, alignment: .leading)

                                            Text(recipe.ingredients[index].ingredientName)
                                                .lineLimit(1)
                                                .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                                .frame(width: thirdWidth, alignment: .leading)
                                                .layoutPriority(1)
                                    }
                                    .frame(width: totalWidth, alignment: .leading)
                                }
                                .frame(height: 30)
                                
                            Spacer()
                            
                            Divider()
                    }
                }
                .padding(.top, -10)
                    
                    Text("Recipe Portion")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    HStack{
                        Text("\(recipe.portion)")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(.quartenaryGray)
                            .frame(width: 220, alignment: .leading)
                            .padding()
                            .background(.primaryGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .opacity(0.6)
                            )
                        
                        Text("\(recipe.portionUnit)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.quartenaryGray)
                            .frame(width: 80, alignment: .leading)
                            .padding()
                            .background(.primaryGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .opacity(0.6)
                            )
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
                
                NavigationLink{
                    PortionResultView(recipePortion: recipe.portion, recipePortionUnit: recipe.portionUnit, ingredients: recipe.ingredients, navigationPath: $navigationPath)
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
            }
            .padding()
            .navigationTitle("Recipe Detail")
    }
}
