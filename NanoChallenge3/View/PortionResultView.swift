import SwiftUI

struct PortionResultView: View {
    
    @State private var recipePortionInput = 0.0
    @FocusState private var focusedField: Bool
    @State private var isButtonClicked = false
    var recipePortion: Int
    var recipePortionUnit: String
    var ingredients: [Ingredient]
    @State private var portionMultiplier = 0.0
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if !isButtonClicked {
                        Image("Progress3")
                            .padding(.top, 20)
                    }
                    
                    Text("Recipe portion")
                        .fontWeight(.bold)
                        .font(.title2)
                    Text("Enter the portions that the recipe yields")
                        .fontWeight(.light)
                        .font(.body)
                    
                    HStack {
                        HStack(alignment: .center, spacing: 8) {
                            Text("\(recipePortion)")
                                .fontWeight(.bold)
                                .font(.body)
                                .foregroundStyle(.quaternary)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(width: 256, alignment: .leading)
                        .cornerRadius(4)
                        .background(.gray.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.6)
                        )
                        
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Text(recipePortionUnit)
                                .fontWeight(.semibold)
                                .font(.body)
                                .foregroundStyle(.quaternary)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(width: 93, height: 47 ,alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.6)
                        )
                        .background(.gray.opacity(0.1))
                        .cornerRadius(4)
                        
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
                
                VStack(alignment: .leading) {
                    Text("Target portion")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.top, 20)
                    
                    Text("Your target portion to make")
                        .fontWeight(.light)
                        .font(.body)
                    
                    HStack {
                        HStack(alignment: .center, spacing: 8) {
                            TextField(
                                "",
                                value: $recipePortionInput,
                                format: .number
                            )
                            .keyboardType(.decimalPad)
                            .font(.body)
                            .fontWeight(.bold)
                            .focused($focusedField)
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
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        focusedField = false
                                    }
                                }
                            }
                        }
                        
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Text(recipePortionUnit)
                                .fontWeight(.semibold)
                                .font(.body)
                                .foregroundStyle(.quaternary)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(width: 93, height: 47 ,alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.6)
                        )
                        .background(.gray.opacity(0.1))
                        .cornerRadius(4)
                        
                    }
                }
                
                
                if isButtonClicked {
                    VStack(alignment: .leading) {
                        Text("Ingredients information")
                            .fontWeight(.bold)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 2)
                            
                        
                        Text("Composition needed to fulfill your target")
                            .fontWeight(.light)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 20) // Add padding to space from the next component
                            
                        
                        VStack(alignment: .center, spacing: 12) {
                            ForEach(ingredients, id: \.self) { ingredient in
                                HStack(alignment: .center, spacing: 0) {
                                    Text(Double(ingredient.ingredientQuantity) * portionMultiplier, format: .number.precision(.fractionLength(2)))
                                        .font(.body)
                                        .frame(width: 96, alignment: .leading)
                                        .padding(.vertical, 4)
                                        .background(
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(height: 1)
                                                .offset(y: 20) // Move the line down to give space between text and line
                                        )
                                    
                                    Text(ingredient.ingredientUnit)
                                        .font(.body)
                                        .frame(width: 93, alignment: .leading)
                                        .padding(.vertical, 4)
                                        .background(
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(height: 1)
                                                .offset(y: 20) // Move the line down to give space between text and line
                                        )
                                    
                                    Text(ingredient.ingredientName)
                                        .font(.body)
                                        .frame(width: 160, alignment: .leading)
                                        .padding(.vertical, 4)
                                        .background(
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(height: 1)
                                                .offset(y: 20) // Move the line down to give space between text and line
                                        )
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        .padding(.bottom, 20) // Add padding for space between scroll view and button
                    }
                    .padding()
                }
            }
        }
        
        // Buttons section
        VStack {
            if !isButtonClicked {
                Button {
                    isButtonClicked = true
                    portionMultiplier = recipePortionInput / Double(recipePortion)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.accentColor)
                        
                        Text("Calculate")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 361, height: 60)
                }
                .disabled(recipePortionInput == 0)
                .tint(.accentColor)
                .padding(.bottom, 20) // Ensure there's spacing from the bottom
            } else {
                Button(action: {
                    navigationPath = NavigationPath() // Reset the path to the root
                }) {
                    Text("Back to Recipe Page")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 361, height: 46)
                        .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.accentColor))
                }
                .padding(.bottom, 20) // Spacing from the bottom edge
            }
        }
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        .navigationTitle("Calculate portion")
        
    }
    
}
