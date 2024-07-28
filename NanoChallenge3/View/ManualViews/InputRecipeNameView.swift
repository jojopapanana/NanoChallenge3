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
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
            ScrollView{
                VStack(alignment: .leading){
                    Text("Insert recipe detail")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack{
                        Spacer()
                        progressBarSecond()
                            .padding(.vertical, 30)
                        Spacer()
                    }
                    
                    Text("Recipe Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    TextField("E.g. Cookies",
                              text: $recipeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Photo of the food")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    ZStack{
                        if let recipeImage{
                            Image(uiImage: recipeImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 361, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.secondaryGray)
                            
                            VStack{
                                Image(systemName: "square.and.arrow.up")
                                    .font(.largeTitle)
                                
                                Text("Insert your food image here")
                            }
                            .foregroundStyle(.tertiaryGray)
                        }
                    }
                    .frame(height: 200)
                    .padding(.top, 20)
                    .onTapGesture {
                        self.showingImagePicker = true
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, image: $recipeImage)
                    }
                }
                .padding()
            }
            .onDisappear {
                vm.menuName = recipeName
                vm.ingredientList = ingredients
                vm.portion = recipePortion
                vm.portionUnit = recipePortionUnit
                vm.imageData = recipeImage?.pngData()
                vm.saveRecipe(context: context)
            }
        
        NavigationLink{
            PortionResultView(recipePortion: recipePortion, recipePortionUnit: recipePortionUnit, ingredients: ingredients, navigationPath: $navigationPath, fromRecipeDetail: false)
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
