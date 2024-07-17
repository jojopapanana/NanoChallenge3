//
//  InputRecipeFromPictView.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 16/07/24.
//

import SwiftUI


struct InputRecipeFromPictView: View {
    @State private var ingredients:[Ingredient] = []
    @State private var tempIngredient:Ingredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "gr")
    @State private var recipePortion:Int = 0
    @State private var recipePortionUnit:String = "gr"
    private var portionUnit = ["unit", "gr", "kg", "pc"]
    @State private var recipeSellingPrice = 0
    @ObservedObject private var vm = InputRecipeViewModel()
    @State private var isPresented = false
    @State private var ingredient: Ingredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "")
    
    @StateObject private var recognizeImage = recognizeText()
    @Environment(\.modelContext) private var modelContext
    @State private var imageAttributes: ImageAttribute?
    @State private var isRowIngredientView = false
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Insert Recipe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 16)
                    
                    Image("Progress")
                    
                    Text("Ingredients Recipe")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    ScrollView{
                        ForEach(0..<ingredients.count, id: \.self) { index in
                            if(index == 0){
                                IngredientRowView(ingredient: $ingredients[index], isRowIngredientView: $isRowIngredientView)
                                    .frame(height: 80)
                                    .padding(.top, -15)
                            } else {
                                IngredientRowView(ingredient: $ingredients[index], isRowIngredientView: $isRowIngredientView)
                                    .frame(height: 80)
                                    .padding(.top, -25)
                            }
                            
                        }
                    }
                    .frame(maxHeight: 200)

//                    Button {
//                        recognizeImage.recognizeText()
//                        addIngredientFromPict()
//                    } label: {
//                        Text("Kuy")
//                    }
                    
                    Text("Recipe Portion")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    Text("Enter the portions that the recipe yields")
                        .font(.body)
                    
                    HStack{
                        TextField(
                            "0",
                            value: $recipePortion,
                            format: .number
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        
                        Button{
                            isPresented.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color.clear)
                                
                                Text("\(recipePortionUnit)")
                            }
                            .frame(width: 80, height: 30)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        }
                    }
                    
                    Text("Selling Price")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    HStack{
                        Text("Rp")
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        TextField(
                            "0",
                            value: $recipeSellingPrice,
                            format: .number
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    }
                }
                .onAppear {
                    print("View appeared")
                    recognizeImage.modelContext = modelContext
                    recognizeImage.imageAttributes = imageAttributes
                    recognizeImage.recognizeText()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        print("Calling addIngredientFromPict")
                        addIngredientFromPict()
                    }
                }
                
                NavigationLink{
                    InputRecipeNameView(ingredients: ingredients, recipePortion: recipePortion, recipePortionUnit: recipePortionUnit, recipePrice: recipeSellingPrice)
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
                .disabled(ingredients.isEmpty || recipePortion == 0 || recipeSellingPrice == 0)
            }
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            VStack{
                Picker("Please choose a recipe portion unit", selection: $recipePortionUnit){
                    ForEach(portionUnit, id:\.self){ unit in
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
        })
        .tint(.accentColor)
    }
    
    private func addIngredientFromPict() {
        for index in 0..<recognizeImage.namaBahanArr.count {
            let ingredientName = recognizeImage.namaBahanArr[index]
            let ingredientQuantity = Int(recognizeImage.qtyArr[index]) ?? 0
            let ingredientUnit = recognizeImage.satuanArr[index]
            
            tempIngredient = Ingredient(ingredientName: ingredientName, ingredientQuantity: ingredientQuantity, ingredientUnit: ingredientUnit)
            
            ingredients.append(tempIngredient)
            
            tempIngredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "")
        }
    }
    


}

//#Preview {
//    InputRecipeFromPictView()
//}
