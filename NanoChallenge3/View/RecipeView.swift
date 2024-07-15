//
//  RecipeView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI
import SwiftData

struct SampleImage: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

let sampleImages : [SampleImage] = [
    SampleImage(title: "Ahmad", imageName: "kucingjelek"),
    SampleImage(title: "Butet", imageName: "tewas")
]
struct Constants {
static let GraysWhite: Color = .white
}

struct RecipeView: View {
    @Query private var recipes:[Recipe]
    
    var body: some View {
        NavigationStack {
            VStack {
                if sampleImages.isEmpty {
                                    recipeCardEmpty()
                } else {
                    TabView {
                        ForEach(sampleImages) { sampleImage in
                            VStack (alignment: .leading){
                                Image(sampleImage.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 361, height: 257)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 10)
                                    .padding(10)
                                    
                                Text(sampleImage.title)
                                    .font(.title)
                                    .padding(.bottom, 20)
                                    .padding(.horizontal, 20)
                                    .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.49))
                            }
                            .background(Color(Color(Color(red: 0.6, green: 0.64, blue: 0.67))))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .padding(.bottom, 50)
                }

                Spacer()

                NavigationLink {
                    ChooseInputView()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.button)
                        
                        Text("Insert Recipe")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .font(.title2)
                    }
                    .padding()
                    .frame(width: 361, height: 100)
                }
            }
            .navigationTitle("Recipes")
            .padding(.top, 10)
        }
    }
}

#Preview {
    RecipeView()
}
