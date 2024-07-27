//
//  PortionResultView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI

struct PortionResultView: View {
    
    @State private var recipePortionInput = 0.0
    @FocusState private var focusedField:Bool
    @State private var isButtonClicked = false
    var recipePortion:Int
    var recipePortionUnit:String
    var recipeSellingPrice:Int
    var ingredients:[Ingredient]
    @State private var portionMultiplier = 0.0
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
//        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    if !isButtonClicked{
                        progressBarThird()
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                    }
                    
                    Text("Recipe portion")
                        .fontWeight(.bold)
                        .font(.title)
                    Text("Enter the portions that the recipe yields")
                        .fontWeight(.light)
                        .font(.body)
                    
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            Text("\(recipePortion)")
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .foregroundStyle(.quartenaryGray)
                        }
                        .padding()
                        .frame(width: 256, height: 75, alignment: .leading)
                        .background(.primaryGray)
                        .cornerRadius(4)
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Text(recipePortionUnit)
                                .fontWeight(.semibold)
                                .font(.title3)
                                .foregroundStyle(.quartenaryGray)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            Spacer()
                        }
                        .padding()
                        .frame(width: 93, height: 75, alignment: .center)
                        .background(.primaryGray)
                        .cornerRadius(4)
                    }
                }
                .padding(.top, 20)
                .frame(width: 361, alignment: .topLeading)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Target portion")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.top, 20)
                    
                    Text("Your target portion to make")
                        .fontWeight(.light)
                        .font(.body)
                    
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            TextField(
                                "",
                                value: $recipePortionInput,
                                format: .number
                            )
                            .keyboardType(.decimalPad)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .focused($focusedField)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        focusedField = false
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(width: 256, height: 75, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                            .inset(by: 0.5)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.6)
                        )
                        .cornerRadius(4)
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Text(recipePortionUnit)
                                .fontWeight(.semibold)
                                .font(.title3)
                                .foregroundStyle(.quartenaryGray)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            Spacer()
                        }
                        .padding()
                        .frame(width: 93, height: 75, alignment: .center)
                        .background(.primaryGray)
                        .cornerRadius(4)
                    }
                }
                .padding(.top, 10)
                .frame(width: 361, alignment: .topLeading)
                
                
                if isButtonClicked{
                    VStack {
                        Text("Ingredients information")
                            .fontWeight(.bold)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Composition needed to fulfill your target")
                            .fontWeight(.light)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack{
                            ForEach(ingredients, id:\.self){ingredient in
                                HStack(alignment: .center, spacing: 12) {
                                    HStack{
                                        Text(Double(ingredient.ingredientQuantity)*portionMultiplier, format: .number.precision(.fractionLength(2)))
                                            .fontWeight(.bold)
                                            .font(.title3)
                                    }
                                    .padding()
                                    .frame(maxWidth: 150, alignment: .leading)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                    )
                                    
                                    HStack{
                                        Text(ingredient.ingredientUnit)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                    }
                                    .padding()
                                    .frame(width: 68, alignment: .leading)
                                    .cornerRadius(8)
                                    .overlay(
                                      RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                    )
                                    
                                    HStack{
                                        Text(ingredient.ingredientName)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .cornerRadius(8)
                                    .overlay(
                                      RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(.gray, lineWidth: 1)
                                    )
                                }
                            }
                            
                            VStack(alignment: .leading){
                                Text("Money Earned")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 20)
                                
                                Text("Money to be received based on sales")
                                    .fontWeight(.light)
                                    .font(.body)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack{
                                    Text("Rp")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                    
                                    Text(Double(recipeSellingPrice)*portionMultiplier, format: .number.precision(.fractionLength(2)))
                                        .fontWeight(.bold)
                                        .font(.title3)
                                }
                                .padding()
                                .frame(width: 361, alignment: .leading)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(.gray, lineWidth: 1)
                                )
                                
                                Button(action: {
                                                navigationPath = NavigationPath() // Reset the path to the root
                                            }) {
                                                Text("Back to Recipe Page")
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .frame(width: 361, height: 60)
                                                    .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.accentColor))
                                            }
                                
//                                NavigationLink {
//                                    RecipeView()
//                                } label: {
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 10.0)
//                                        
//                                        Text("Back to recipe page")
//                                            .font(.title3)
//                                            .fontWeight(.semibold)
//                                            .foregroundStyle(Color.white)
//                                    }
//                                    .frame(width: 361, height: 60)
//                                    .padding(.top, 20)
//                                }
//                                .tint(.accentColor)
//                                .padding(.top, 20)
                            }
                        }
                    }
                    .padding()
                } else {
                    Button {
                        isButtonClicked = true
                        portionMultiplier = recipePortionInput/Double(recipePortion)
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
                    .disabled(recipePortionInput == 0)
                    .tint(.accentColor)
                    .padding(.top, 50)
                }
                Spacer()
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
//        }
        .navigationTitle("Calculate Recipe")
    }
}

//#Preview {
//    PortionResultView(recipePortion: 0, recipePortionUnit: "gr", recipeSellingPrice: 0, ingredients: [Ingredient(ingredientName: "sugar", ingredientQuantity: 100, ingredientUnit: "gr")])
//}
