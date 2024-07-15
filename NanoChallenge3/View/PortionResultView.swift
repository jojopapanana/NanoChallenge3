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
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Enter the portions that the recipe yields")
                        .fontWeight(.light)
                        .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            // Headline
                            Text("600")
                                .fontWeight(.bold)
                                .font(.system(size: 63))
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
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
//                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26))
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
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Your target portion want to make")
                        .fontWeight(.light)
                        .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // buat input
                    
                    HStack{
                        HStack(alignment: .center, spacing: 8) {
                            // Headline
                            TextField("", text: $recipePortionInput)
                                .focused($focusedField, equals: .dec)
                                .numbersOnly($recipePortionInput)
                                .fontWeight(.bold)
                                .font(.system(size: 63))
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
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
//                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26))
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
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                          .foregroundColor(Color(red: 0, green: 0.54, blue: 0.82))
                          .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Body/Body 3
                        Text("Composition needed to fulfill your target")
                            .fontWeight(.light)
                            .font(.system(size: 16))
                          .foregroundColor(Color(red: 0.2, green: 0.72, blue: 1))
                          .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView{
                            HStack(alignment: .center, spacing: 12) {
                                HStack(alignment: .center, spacing: 20) {
                                    Text("1000")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
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
                                        .fontWeight(.semibold)
                                        .font(.system(size: 16))
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
                                        .fontWeight(.semibold)
                                        .font(.system(size: 16))
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
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
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
