//
//  ScanInstructions.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 14/07/24.
//

import SwiftUI

struct ScanInstructions: View {
    @Binding var navigationPath:NavigationPath
    
    var body: some View {
//        NavigationStack{
            VStack{
//                NavigationStack {
                    VStack {
                        InstructionStep(number: "1.", title: LocalizedStringKey("Click start button"), description: LocalizedStringKey("Click the insert recipe button below to add a recipe using the camera."))
                            .padding(.bottom, 20)
                        InstructionStep(number: "2.", title: LocalizedStringKey("Allow access camera"), description: LocalizedStringKey("Approve camera access to take a picture of the recipe."))
                            .padding(.bottom, 20)
                        InstructionStep(number: "3.", title: LocalizedStringKey("Scan recipe ingredients"), description: LocalizedStringKey("Take photos focusing only on ingredients for easier scanning."))
                            .padding(.bottom, 20)
                        
                    }
                    .padding()
                    .navigationTitle(LocalizedStringKey("Instructions"))
//                }
                Spacer()
                NavigationLink {
                    ScanningView(navigationPath: $navigationPath)
                } label: {
                    HStack(alignment: .center, spacing: 4) {
                        Text("Start")
                        .font(
                        Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                        )
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(width: 361, alignment: .center)
                    .background(Color.button)
                    .cornerRadius(12)
                    
                }
            }
            .padding()
            .navigationTitle("Instructions")
            
//        }
    }
}

struct InstructionStep: View {
    let number: String
    let title: LocalizedStringKey
    let description: LocalizedStringKey
    
    var body: some View {
        HStack(alignment: .top) {
            Text(number)
                .fontWeight(.bold)
                .font(.title)
                .frame(width: 30, alignment: .leading)
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                Text(description)
                    .fontWeight(.light)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .padding(.horizontal)
    }
}


//#Preview {
//    ScanInstructions()
//}
