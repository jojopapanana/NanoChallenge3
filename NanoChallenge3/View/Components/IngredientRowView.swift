//
//  IngredientRowView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 12/07/24.
//

import SwiftUI

struct IngredientRowView: View {
    @StateObject var vm = InputRecipeViewModel()
    var unitOptions = ["unit", "gr", "kg", "pc", "tsp", "tbsp", "cup", "oz", "ml", "l"]
    @Binding var ingredient: Ingredient
    @State private var isPresented = false
    @Environment(\.presentationMode) var presentationMode
    @FocusState var focusedField:Bool
    @Binding var isRowIngredientView:Bool
    
    var body: some View {
            HStack{
                TextField(
                    "0",
                    value: $ingredient.ingredientQuantity,
                    format: .number
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
                .keyboardType(.decimalPad)
                .focused($focusedField)
                
                Button{
                    isPresented.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.clear)
                        
                        Text("\(ingredient.ingredientUnit)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                    }
                    .frame(width: 80, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
                
                
                TextField("Input ingredient name...",
                          text: $ingredient.ingredientName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focusedField)
            }
            .sheet(isPresented: $isPresented){
                VStack{
                    Picker("Please choose an ingredient", selection: $ingredient.ingredientUnit){
                        ForEach(unitOptions, id:\.self){ unit in
                            Text(unit)
                                .font(.body)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Done")
                            .font(.headline)
                            .padding()
                            .background(.button)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
    }
}

struct IngredientRow_Previews: PreviewProvider {
    @State static var ingredient = Ingredient(ingredientName: "Sugar", ingredientQuantity: 1, ingredientUnit: "kg")
    @State static var bool = false
    
    static var previews: some View {
        IngredientRowView(ingredient: $ingredient, isRowIngredientView: $bool)
    }
}
