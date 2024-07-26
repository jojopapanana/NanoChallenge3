import SwiftUI

struct InputRecipeView: View {
    
    @FocusState var focusedField: Field?
    @State var ingredients: [Ingredient] = [Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit")]
    @State var recipePortion: Int = 0
    @State var recipePortionUnit: String = "unit"
    var portionUnit = ["unit", "gr", "kg", "pc"]
    @State var isPresented = false
    @State var isRowIngredientView = false
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
                    
                    ScrollView {
                        ForEach($ingredients, id: \.id) { $ingredient in
                            IngredientRowView(
                                ingredient: $ingredient,
                                isRowIngredientView: $isRowIngredientView,
                                onDelete: {
                                    deleteIngredient(ingredient)
                                }
                            )
                            .frame(height: 80)
                            .padding(.top, $ingredients.firstIndex(where: { $0.id == ingredient.id }) == 0 ? -15 : -25)
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
                            .focused($focusedField, equals: .recipePortion)
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
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
            

            Spacer()

            NavigationLink {
                InputRecipeNameView(ingredients: ingredients, recipePortion: recipePortion, recipePortionUnit: recipePortionUnit, navigationPath: $navigationPath)
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
        .navigationTitle("Input ingredients detail")
        .padding()
        .sheet(isPresented: $isPresented, content: {
            VStack {
                Picker("Please choose a recipe portion unit", selection: $recipePortionUnit) {
                    ForEach(portionUnit, id: \.self) { unit in
                        Text(unit)
                            .font(.title)
                            .padding(.bottom, 20)
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
        .tint(.button)
    }
    
    private func addIngredient() {
        ingredients.append(Ingredient(ingredientName: "", ingredientQuantity: 0, ingredientUnit: "unit"))
    }
    
    private func deleteIngredient(_ ingredient: Ingredient) {
        if let index = ingredients.firstIndex(where: { $0.id == ingredient.id }) {
            ingredients.remove(at: index)
        }
    }
}
