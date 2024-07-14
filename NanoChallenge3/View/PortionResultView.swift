//
//  PortionResultView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI

struct PortionResultView: View {
    
    enum FocusedField{
        case dec
    }
    
    @State private var recipePortionInput = ""
    @FocusState private var focusedField: FocusedField?
    @State private var isButtonClicked = false
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading, spacing: 20) {
                    Text("Recipe portion")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.bold)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Enter the portions that the recipe yields")
                    .font(
                    Font.custom("SF Pro", size: 16)
                    .weight(.light)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            // Headline
                            Text("600")
                            .font(
                            Font.custom("SF Pro", size: 63)
                            .weight(.bold)
                            )
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(width: 256, alignment: .leading)
                        .background(Color(red: 0.47, green: 0.47, blue: 0.5))
                        .opacity(0.2)
                        .cornerRadius(4)
                        HStack(alignment: .center) {
                            Spacer()
                            Text("gr")
                            .font(
                            Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                            )
                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(width: 93, height: 94, alignment: .center)
                        .background(Color(red: 0.47, green: 0.47, blue: 0.5))
                        .opacity(0.2)                        .cornerRadius(4)
                    }
                }
                .padding(0)
                .padding(.top, 40)
                .frame(width: 361, alignment: .topLeading)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Target portion")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.bold)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Your target portion want to make")
                    .font(
                    Font.custom("SF Pro", size: 16)
                    .weight(.light)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // buat input
                    
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            // Headline
                            TextField("", text: $recipePortionInput)
                                .focused($focusedField, equals: .dec)
                                .numbersOnly($recipePortionInput)
                            .font(
                            Font.custom("SF Pro", size: 63)
                            .weight(.bold)
                            )
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(width: 256, alignment: .leading)
                        .overlay(
                        RoundedRectangle(cornerRadius: 4)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.47, green: 0.47, blue: 0.5), lineWidth: 1)
                        .opacity(0.6)
                        )
                        .cornerRadius(4)
                        HStack(alignment: .center) {
                            Spacer()
                            Text("gr")
                            .font(
                            Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                            )
                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(width: 93, height: 94, alignment: .center)
                        .background(Color(red: 0.47, green: 0.47, blue: 0.5))
                        .opacity(0.2)                        .cornerRadius(4)
                    }
                }
                .padding(0)
                .padding(.top, 10)
                .frame(width: 361, alignment: .topLeading)
                
                if isButtonClicked{
                    VStack {
                        // Body/Body Semibold 2
                        Text("Ingredients information")
                          .font(
                            Font.custom("SF Pro", size: 20)
                              .weight(.semibold)
                          )
                          .foregroundColor(Color(red: 0, green: 0.54, blue: 0.82))
                          .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Body/Body 3
                        Text("Composition needed to fulfill your target")
                          .font(
                            Font.custom("SF Pro", size: 16)
                              .weight(.light)
                          )
                          .foregroundColor(Color(red: 0.2, green: 0.72, blue: 1))
                          .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView{
                            HStack(alignment: .center, spacing: 12) {
                                HStack(alignment: .center, spacing: 20) {
                                    Text("1000")
                                    .font(
                                    Font.custom("SF Pro", size: 16)
                                    .weight(.semibold)
                                    )
                                    .foregroundColor(Color(red: 0, green: 0.54, blue: 0.82))

                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                                .frame(width: 96, alignment: .leading)
                                .cornerRadius(8)
                                .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.2, green: 0.72, blue: 1), lineWidth: 1)
                                )
                                
                                HStack(alignment: .center, spacing: 20) {
                                    // Body/Body Semibold 3
                                    Text("gr")
                                      .font(
                                        Font.custom("SF Pro", size: 16)
                                          .weight(.semibold)
                                      )
                                      .foregroundColor(Color(red: 0, green: 0.54, blue: 0.82))
                                      .frame(maxWidth: .infinity, alignment: .topLeading)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                                .frame(width: 68, alignment: .leading)
                                .cornerRadius(8)
                                .overlay(
                                  RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.2, green: 0.72, blue: 1), lineWidth: 1)
                                )
                                
                                HStack(alignment: .center, spacing: 20) {
                                    // Body/Body Semibold 3
                                    Text("salted butter")
                                      .font(
                                        Font.custom("SF Pro", size: 16)
                                          .weight(.semibold)
                                      )
                                      .foregroundColor(Color(red: 0, green: 0.54, blue: 0.82))
                                      .frame(maxWidth: .infinity, alignment: .topLeading)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .cornerRadius(8)
                                .overlay(
                                  RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.2, green: 0.72, blue: 1), lineWidth: 1)
                                )
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding()
                } else {
                    Button {
                        isButtonClicked = true
                    } label: {
                        HStack(alignment: .center, spacing: 4) {
                            Text("Calculate")
                            .font(
                            Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                            )
                            .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .frame(width: 361, alignment: .center)
                        .background(Color(red: 1, green: 0.22, blue: 0.36))
                        .cornerRadius(12)
                    }
                    .padding(.top, 50)
                }
                
                Spacer()
            }
            .navigationTitle("Calculate Recipe")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                }
                ToolbarItem(placement: .keyboard) {
                    Button {
                        focusedField = nil
                    } label: {
                        Text("Done")
                    }
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
        }
    }
}

#Preview {
    PortionResultView()
}
