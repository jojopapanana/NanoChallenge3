//
//  InputRecipeFromPictView.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 16/07/24.
//

import SwiftUI


struct InputRecipeFromPictView: View {
    @FocusState var focusedField:Bool
    @State var ingredients:[Ingredient] = []
    @State var tempIngredient:Ingredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")
    @State var recipePortion:Int = 0
    @State var recipePortionUnit:String = "unit"
    var portionUnit = ["unit", "gr", "kg", "pc"]
    @State var recipeSellingPrice = 0
    @State var isPresented = false
    @State var isRowIngredientView = false
    
    @StateObject var recognizeImage = recognizeText()
    @Environment(\.modelContext) var modelContext
    @State var imageAttributes: ImageAttribute?
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
            ScrollView{
                VStack(alignment: .leading){
                    Image("Progress")
                        .padding(.top, 20)
                    
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
                                    .onTapGesture {
                                        isRowIngredientView = true
                                    }
                            } else {
                                IngredientRowView(ingredient: $ingredients[index], isRowIngredientView: $isRowIngredientView)
                                    .frame(height: 80)
                                    .padding(.top, -25)
                                    .onTapGesture {
                                        isRowIngredientView = true
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
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    Text("Enter the portions that the recipe yields")
                        .font(.body)
                    
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
                            .frame(width: 80, height: 30)
                        }
                        .padding()
                        .frame(width: 80, height: 75, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                            .inset(by: 0.5)
                            .stroke(.gray, lineWidth: 1)
                            .opacity(0.6)
                        )
                        .cornerRadius(4)
                        .buttonStyle(PlainButtonStyle())
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
                        .focused($focusedField)
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
                    InputRecipeNameView(ingredients: ingredients, recipePortion: recipePortion, recipePortionUnit: recipePortionUnit, recipePrice: recipeSellingPrice, navigationPath: $navigationPath)
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
            .navigationTitle("Insert Recipe")
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
    
    private func addIngredient() {
        ingredients.append(tempIngredient)
        tempIngredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")
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
