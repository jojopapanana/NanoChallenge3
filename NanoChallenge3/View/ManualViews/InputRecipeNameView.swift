//
//  InputRecipeNameView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 12/07/24.
//

import SwiftUI
import SwiftData

struct InputRecipeNameView: View {
    
    @State private var recipeName = ""
    @State private var recipeImage:UIImage?
    @State private var showingImagePicker = false
    @ObservedObject private var vm = InputRecipeViewModel()
    @Environment(\.modelContext) private var context
    var ingredients:[Ingredient]
    var recipePortion:Int
    var recipePortionUnit:String
    var recipePrice:Int
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
//        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Image("Progress2")
                        .padding(.top, 20)
                    
                    Text("Recipe Name")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    TextField("E.g. Cookies",
                              text: $recipeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Photo of the cookie/cake")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    ZStack{
                        if let recipeImage{
                            Image(uiImage: recipeImage)
                                .resizable()
                                .frame(height: 200)
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.secondaryGray)
                                .frame(height: 200)
                            
                            VStack{
                                Image(systemName: "square.and.arrow.up")
                                    .font(.largeTitle)
                                
                                Text("Insert your cookie/cake image here")
                            }
                            .foregroundStyle(.tertiaryGray)
                        }
                    }
                    .onTapGesture {
                        self.showingImagePicker = true
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, image: $recipeImage)
                    }
                }
                .padding()
            }
//            .padding(.top, -100)
            .onDisappear {
                vm.menuName = recipeName
                vm.ingredientList = ingredients
                vm.portion = recipePortion
                vm.portionUnit = recipePortionUnit
                vm.menuPrice = recipePrice
                vm.imageData = recipeImage?.pngData()
                vm.saveRecipe(context: context)
            }
//        }
        .navigationTitle("Insert Recipe")
        
        NavigationLink{
            PortionResultView(recipePortion: recipePortion, recipePortionUnit: recipePortionUnit, recipeSellingPrice: recipePrice, ingredients: ingredients, navigationPath: $navigationPath)
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10.0)
                
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 361, height: 46)
            .padding(.top, 20)
        }
        .disabled(recipeName.isEmpty)
        .tint(.accentColor)
        Spacer()
    }
}

//#Preview {
//    InputRecipeNameView()
//}
