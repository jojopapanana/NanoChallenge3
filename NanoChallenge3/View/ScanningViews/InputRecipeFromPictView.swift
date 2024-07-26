import SwiftUI

struct InputRecipeFromPictView: View {
    @FocusState private var focusedField: Field? // Define a specific enum to manage focus states
    @State var ingredients: [Ingredient] = []
    @State var tempIngredient: Ingredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")
    @State var recipePortion: Int = 0
    @State var recipePortionUnit: String = "unit"
    var portionUnit = ["unit", "gr", "kg", "pc"]
    @State var isPresented = false
    @State var isRowIngredientView = false
    @StateObject var recognizeImage = recognizeText()
    @Environment(\.modelContext) var modelContext
    @State var imageAttributes: ImageAttribute?
    @Binding var navigationPath: NavigationPath

    enum Field: Hashable {
        case recipePortion
        case ingredientQuantity
        case ingredientName
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Image("Progress")
                    
                    Text("Ingredients Recipe")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    ScrollView {
                        ForEach(0..<ingredients.count, id: \.self) { index in
                            IngredientRowView(
                                ingredient: $ingredients[index],
                                isRowIngredientView: $isRowIngredientView,
                                onDelete: {
                                    deleteIngredient(at: index)
                                }
                            )
                            .frame(height: 80)
                            .padding(.top, index == 0 ? -15 : -25)
                            .focused($focusedField, equals: .ingredientQuantity)
                            .onTapGesture {
                                isRowIngredientView = true
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    
                    Button(action: addIngredient) {
                        HStack {
                            Image(systemName: "plus.square.fill")
                                .foregroundColor(.accentColor)
                            Text("Add more ingredients")
                                .fontWeight(.semibold)
                                .font(.body)
                                .foregroundColor(.accentColor)
                            Spacer()
                        }
                    }
                    
                    Text("Recipe Portion")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    Text("Enter the portions that the recipe yields")
                        .font(.body)
                    
                    HStack {
                        HStack(alignment: .center, spacing: 8) {
                            TextField(
                                "",
                                value: $recipePortion,
                                format: .number
                            )
                            .keyboardType(.decimalPad)
                            .font(.body)
                            .fontWeight(.bold)
                            .focused($focusedField, equals: .recipePortion) // Manage focus state
                            .onTapGesture {
                                isRowIngredientView = false
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .frame(width: 256, alignment: .leading)
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .inset(by: 0.5)
                                    .stroke(.gray, lineWidth: 1)
                                    .opacity(0.6)
                            )
                            .cornerRadius(4)
                        }
                        
                        Button {
                            isPresented.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color.clear)
                                
                                Text("\(recipePortionUnit)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .frame(width: 93, alignment: .center)
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
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
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
                if !isRowIngredientView {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusedField = nil // Dismiss the keyboard
                        }
                    }
                }
            }
            .navigationTitle("Insert Recipe")
            
            Spacer()
            
            NavigationLink {
                InputRecipeNameView(
                    ingredients: ingredients,
                    recipePortion: recipePortion,
                    recipePortionUnit: recipePortionUnit,
                    navigationPath: $navigationPath
                )
            } label: {
                ZStack {
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
        .padding()
        .sheet(isPresented: $isPresented, content: {
            VStack {
                Picker("Please choose a recipe portion unit", selection: $recipePortionUnit) {
                    ForEach(portionUnit, id: \.self) { unit in
                        Text(unit)
                            .font(.title)
                            
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.bottom, 20)
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Done")
                        .font(.headline)
                        .padding()
                        .background(Color.button)
                        .foregroundColor(.accentColor)
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
    
    private func addIngredient() {
        ingredients.append(tempIngredient)
        tempIngredient = Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")
    }
    
    private func deleteIngredient(at index: Int) {
        ingredients.remove(at: index)
    }
}
