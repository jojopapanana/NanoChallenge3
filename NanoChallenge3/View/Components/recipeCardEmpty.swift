//
//  recipeCardEmpty.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 12/07/24.
//

import SwiftUI

struct recipeCardEmpty: View {
    var body: some View {
//        HStack(alignment: .center, spacing: 4) {
//            // Body/Body 3
//            Text("No cake recipe available")
//                .font(.body)
//                .multilineTextAlignment(.center)
//                .foregroundColor(.gray)
//        }
//        .frame(width: 361, height: 342, alignment: .center)
//        .background(Color(red: 0.79, green: 0.82, blue: 0.85))
//        .cornerRadius(20)
        
        VStack {
            Image("Grandma")
            
            VStack {
                Text("There is no recent recipe for now")
                    .fontWeight(.bold)
                    .font(.body)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .top)
            .padding(.top, 35)
            }
            
            Text("Insert your recipe by selecting the method below")
                .fontWeight(.light)
                .font(.body)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 1)
        }
        .padding()
    }
}

#Preview {
    recipeCardEmpty()
}
