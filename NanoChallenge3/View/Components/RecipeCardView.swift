//
//  RecipeCardView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 24/07/24.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe:Recipe
    @Environment(\.modelContext) var context
    @State private var deleteAlert = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
            
            VStack(alignment: .leading){
                if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(height: 120)
                            .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 10))
                } else {
                    Text("No image available")
                }
                    
                
                Text(recipe.menuName)
                    .foregroundStyle(.menuNameFont)
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding([.top, .horizontal], 8)
                
                Text("\(recipe.portion) \(recipe.portionUnit)")
                    .foregroundStyle(.gray)
                    .font(.body)
                    .padding(.horizontal, 8)
                
                HStack{
                    Spacer()
                    Button(action: {
                        deleteAlert = true
                    }, label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(Color.red)
                    })
                }
                .padding([.bottom, .trailing], 8)
                .alert("Are you sure to delete?", isPresented: $deleteAlert){
                    Button("Yes", role: .destructive){
                        context.delete(recipe)
                    }
                    Button("Cancel", role: .cancel){}
                }
            }
        }
        .padding()
        .frame(width: 200, height: 220)
        .foregroundStyle(Color.clear)
    }
}

//#Preview {
//    RecipeCardView()
//}
