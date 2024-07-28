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
                    Text("Input ingredients detail")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack{
                        Spacer()
                        progressBar()
                            .padding(.vertical, 30)
                        Spacer()
                    }
                    
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
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 15)
                                }
                            }
                            .padding(.trailing)
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
                        HStack(alignment: .center) {
                            TextField(
                                "",
                                value: $recipePortion,
                                format: .number
                            )
                            .keyboardType(.decimalPad)
                            .font(.body)
                            .focused($focusedField)
                            .onTapGesture {
                                isRowIngredientView = false
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .frame(width: 256, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.6)
                            )
                            .cornerRadius(4)
                        }
                        
                        
                        Button{
                            isPresented.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color.clear)
                                
                                Text("\(recipePortionUnit)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .frame(width: 95, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.6)
                            )
                            .cornerRadius(4)
                        }
                        .buttonStyle(PlainButtonStyle())
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
            .padding(.bottom, 20)
        }
    
    private func addIngredient() {
        ingredients.append(tempIngredient)
        tempIngredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")
        
        isRowIngredientView = false
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
