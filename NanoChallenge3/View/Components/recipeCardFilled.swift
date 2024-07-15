//
//  recipeCardFilled.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 12/07/24.
//

import SwiftUI

struct recipeCardFilled: View {
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 361, height: 257)
              .background(Color(red: 0.79, green: 0.82, blue: 0.85))
              .cornerRadius(20)
        }

    }
}

#Preview {
    recipeCardFilled()
}
