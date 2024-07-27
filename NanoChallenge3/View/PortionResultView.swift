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
    var ingredients:[Ingredient]
    @State private var portionMultiplier = 0.0
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
            ScrollView{
                VStack(alignment: .leading) {
                    if !isButtonClicked{
                        Text("Calculate portion")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack{
                            Spacer()
                            progressBarThird()
                                .padding(.vertical, 30)
                            Spacer()
                        }
                    } else {
                        Text("Result calculation")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
                
                VStack(alignment: .leading) {
                    Text("Recipe portion")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.top, 20)
                    
                    Text("Enter the portions that the recipe yields")
                        .font(.body)
                        .foregroundStyle(.gray)
                    
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            Text("\(recipePortion)")
                                .fontWeight(.semibold)
                                .font(.body)
                                .foregroundStyle(.quartenaryGray)
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
                    
                    Text("Target portion")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.top, 20)
                    
                    Text("Your target portion to make")
                        .font(.body)
                        .foregroundStyle(.gray)
                    
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            TextField(
                                "",
                                value: $recipePortionInput,
                                format: .number
                            )
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .keyboardType(.decimalPad)
                            .font(.body)
                            .frame(width: 256, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.6)
                            )
                            .cornerRadius(4)
                            .focused($focusedField)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        focusedField = false
                                    }
                                }
                            }
                            .disabled(isButtonClicked)
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
                .frame(width: 361, alignment: .topLeading)
                
                
                if isButtonClicked{
                    VStack(alignment: .leading){
                        Text("Ingredients information")
                            .fontWeight(.bold)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Composition needed to fulfill your target")
                            .font(.body)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 20)
                        
                        VStack(alignment: .leading){
                            GeometryReader { geometry in
                                    let totalWidth = geometry.size.width
                                    let firstWidth = totalWidth * 1 / 5
                                    let secondWidth = totalWidth * 1 / 5
                                let thirdWidth = totalWidth * 2.75 / 5

                                HStack {
                                        Text("qty")
                                            .fontWeight(.semibold)
                                            .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                            .frame(width: firstWidth, alignment: .leading)

                                        Text("unit")
                                            .fontWeight(.semibold)
                                            .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                            .frame(width: secondWidth, alignment: .leading)

                                        Text("ingredient")
                                        .fontWeight(.semibold)
                                            .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                            .frame(width: thirdWidth, alignment: .leading)
                                }
                                .frame(width: totalWidth, alignment: .leading)
                            }
                            .frame(height: 30)
                            
                            Divider()
                            
                            ForEach(ingredients, id:\.self) { ingredient in
                                    GeometryReader { geometry in
                                            let totalWidth = geometry.size.width
                                            let firstWidth = totalWidth * 1 / 5
                                            let secondWidth = totalWidth * 1 / 5
                                        let thirdWidth = totalWidth * 2.75 / 5

                                        HStack {
                                            Text(Double(ingredient.ingredientQuantity)*portionMultiplier, format: .number.precision(.fractionLength(2)))
                                                    .lineLimit(1)
                                                    .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                                    .frame(width: firstWidth, alignment: .leading)

                                            Text(ingredient.ingredientUnit)
                                                    .lineLimit(1)
                                                    .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                                    .frame(width: secondWidth, alignment: .leading)

                                            Text(ingredient.ingredientName)
                                                    .lineLimit(1)
                                                    .padding(.init(top: 12, leading: 8, bottom: 12, trailing: 8))
                                                    .frame(width: thirdWidth, alignment: .leading)
                                                    .layoutPriority(1)
                                        }
                                        .frame(width: totalWidth, alignment: .leading)
                                    }
                                    .frame(height: 30)
                                    
                                Spacer()
                                
                                Divider()
                        }
                            
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
                            .padding(.top, 50)
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
    }
}

//#Preview {
//    PortionResultView(recipePortion: 0, recipePortionUnit: "gr", recipeSellingPrice: 0, ingredients: [Ingredient(ingredientName: "sugar", ingredientQuantity: 100, ingredientUnit: "gr")])
//}
