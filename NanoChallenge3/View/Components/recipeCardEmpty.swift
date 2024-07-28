//
//  recipeCardEmpty.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 12/07/24.
//

import SwiftUI


struct recipeCardEmpty: View {
    var body: some View {

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
