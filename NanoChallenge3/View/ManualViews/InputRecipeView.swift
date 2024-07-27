//
//  InputRecipeView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI

struct InputRecipeView: View {
    
    @FocusState var focusedField:Bool
    @State var ingredients:[Ingredient] = [Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")]
    @State var tempIngredient:Ingredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")
    @State var recipePortion:Int = 0
    @State var recipePortionUnit:String = "unit"
    var portionUnit = ["unit", "gr", "kg", "pc"]
    @State var isPresented = false
    @State var isRowIngredientView = false
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
            ScrollView{
                VStack(alignment: .leading){
                    Text("Input ingredients detail")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack{
                        Spacer()
                        progressBar()
                            .padding(.vertical, 30)
                        Spacer()
                    }
                    
                    Text("Ingredients Recipe")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    ScrollView{
                        ForEach(0..<ingredients.count, id: \.self) { index in
                            HStack {
                                IngredientRowView(ingredient: $ingredients[index], isRowIngredientView: $isRowIngredientView)
                                    .focused($focusedField)
                                    .frame(height: 80)
                                    .padding(.top, index == 0 ? -15 : -25)
                                    
                                Spacer()
                                
                                Button(action: {
                                    ingredients.remove(at: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding(.bottom, 15)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    
                    Button(action: addIngredient){
                        HStack{
                            Image(systemName: "plus.square.fill")
                            Text("Add more ingredients")
                                .fontWeight(.semibold)
                                .font(.body)
                            Spacer()
                        }
                    }
                    
                    Text("Recipe Portion")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    Text("Enter the portions that the recipe yields")
                        .font(.body)
                        .foregroundStyle(.gray)
                    
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            TextField(
                                "",
                                value: $recipePortion,
                                format: .number
                            )
                            .keyboardType(.decimalPad)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .focused($focusedField)
                            .onTapGesture {
                                isRowIngredientView = false
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
                        
                        Button{
                            isPresented.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color.clear)
                                
                                Text("\(recipePortionUnit)")
                            }
                        }
                        .padding()
                        .frame(width: 95, height: 75, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                            .inset(by: 0.5)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.6)
                        )
                        .cornerRadius(4)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                NavigationLink{
                    InputRecipeNameView(ingredients: ingredients, recipePortion: recipePortion, recipePortionUnit: recipePortionUnit, navigationPath: $navigationPath)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10.0)
                        
                        Text("Next")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 361, height: 46)
                }
                .disabled(ingredients.isEmpty || recipePortion == 0)
            }
            .toolbar {
                if(!isRowIngredientView){
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusedField = false
                        }
                    }
                }
            }
            .navigationTitle("Input ingredients detail")
            .padding()
            .sheet(isPresented: $isPresented, content: {
                VStack{
                    Picker("Please choose a recipe portion unit", selection: $recipePortionUnit){
                        ForEach(portionUnit, id:\.self){ unit in
                            Text(unit)
                                .font(.title3)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Done")
                            .font(.title3)
                            .padding()
                            .background(.button)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            })
            .tint(.accentColor)
        }
    
    private func addIngredient() {
        ingredients.append(tempIngredient)
        tempIngredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")
        
        isRowIngredientView = false
    }
}

//#Preview {
//    InputRecipeView()
//}
