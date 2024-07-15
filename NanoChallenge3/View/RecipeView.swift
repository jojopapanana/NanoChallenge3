//
//  RecipeView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI

// Define the data structure
struct SampleImage: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

// Create the dummy data
let sampleImages : [SampleImage] = [
    SampleImage(title: "Ahmad", imageName: "kucingjelek"),
    SampleImage(title: "Butet", imageName: "tewas")
]
struct Constants {
static let GraysWhite: Color = .white
}

struct RecipeView: View {
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

                Button(action: {
                    // Add action here
                }) {
                    HStack(alignment: .center, spacing: 4) {
                        Text("Insert Recipe")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Constants.GraysWhite)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(width: 361, alignment: .center)
                    .background(Color(red: 0.69, green: 0.73, blue: 0.76))
                    .cornerRadius(12)
                }
                .padding(.bottom, 100)
            }
            .navigationTitle("Recipes")
            .padding(.top, 10)
        }
    }
}

#Preview {
    RecipeView()
}
