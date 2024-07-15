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
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Insert Recipe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Recipe Name")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    TextField("E.g. Cookies",
                              text: $recipeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Food Image")
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
                                
                                Text("Insert your recipe image here")
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
            .onDisappear {
                vm.menuName = recipeName
                vm.ingredientList = ingredients
                vm.portion = recipePortion
                vm.portionUnit = recipePortionUnit
                vm.menuPrice = recipePrice
                vm.imageData = recipeImage?.pngData()
                vm.saveRecipe(context: context)
            }
        }
        
        NavigationLink{
            PortionResultView()
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
