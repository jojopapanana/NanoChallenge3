import SwiftUI

struct IngredientRowView: View {
    @StateObject var vm = InputRecipeViewModel()
    var unitOptions = ["unit", "gr", "kg", "pc", "tsp", "tbsp", "cup", "oz", "ml", "l"]
    @Binding var ingredient: Ingredient
    @State private var isPresented = false
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var focusedField: IngredientField? // Use an enum to identify the field
    @Binding var isRowIngredientView: Bool

    enum IngredientField: Hashable {
        case quantity
        case name
    }

    // Closure for deleting ingredient
    var onDelete: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            TextField(
                "0",
                value: $ingredient.ingredientQuantity,
                format: .number
            )
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .frame(width: 80, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: 0.5)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.6)
            )
            .cornerRadius(4)
            .keyboardType(.decimalPad)
            .focused($focusedField, equals: .quantity) // Focus management for quantity field

            Button {
                isPresented.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.clear)

                    Text("\(ingredient.ingredientUnit)")
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text within the button to the left
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .frame(width: 68, height: 47, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .inset(by: 0.5)
                        .stroke(.gray, lineWidth: 1)
                        .opacity(0.6)
                )
                .cornerRadius(4)
            }
            .buttonStyle(PlainButtonStyle())

            TextField("Input ingredient name...",
                      text: $ingredient.ingredientName)
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading) // Use maxWidth to fill the space and align left
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: 0.5)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.6)
            )
            .cornerRadius(4)
            .focused($focusedField, equals: .name) // Focus management for name field

            Button {
                // Call the delete action when the button is pressed
                onDelete()
            } label: {
                ZStack {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(Color.gray)
                }
            }
        }
        .toolbar {
            if focusedField != nil {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil // Dismiss the keyboard
                    }
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            VStack {
                Picker("Please choose an ingredient", selection: $ingredient.ingredientUnit) {
                    ForEach(unitOptions, id: \.self) { unit in
                        Text(unit)
                            .font(.title)
                            .padding(.bottom, 20)
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
        IngredientRowView(ingredient: $ingredient, isRowIngredientView: $bool, onDelete: {})
    }
}
