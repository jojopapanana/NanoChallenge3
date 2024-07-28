//
//  InstructionStep.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 28/07/24.
//

import SwiftUI

struct InstructionStep: View {
    let number: String
    let title: LocalizedStringKey
    let description: LocalizedStringKey
    
    var body: some View {
        HStack(alignment: .top) {
            Text(number)
                .fontWeight(.bold)
                .font(.title2)
                .frame(width: 30, alignment: .leading)
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title2)
                
                Text(description)
                    .fontWeight(.light)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    InstructionStep(number: "1.", title: "Start", description: "Click start")
}
