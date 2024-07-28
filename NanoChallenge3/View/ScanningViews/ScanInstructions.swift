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
        VStack(alignment: .leading){
                Text("Instructions")
                    .font(.title)
                    .fontWeight(.bold)
                
                    VStack {
                        InstructionStep(number: "1.", title: LocalizedStringKey("Click start button"), description: LocalizedStringKey("Click the insert recipe button below to add a recipe using the camera."))
                            .padding(.bottom, 20)
                        InstructionStep(number: "2.", title: LocalizedStringKey("Allow access camera"), description: LocalizedStringKey("Approve camera access to take a picture of the recipe."))
                            .padding(.bottom, 20)
                        InstructionStep(number: "3.", title: LocalizedStringKey("Scan recipe ingredients"), description: LocalizedStringKey("Take photos focusing only on ingredients for easier scanning."))
                            .padding(.bottom, 20)
                    }
                    .padding(.top, 20)
                
                Spacer()
                
                NavigationLink {
                    ScanningView(navigationPath: $navigationPath)
                } label: {
                    Text("Start")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 361, height: 60)
                        .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.accentColor))
                }
            }
            .padding()
    }
}



//#Preview {
//    ScanInstructions()
//}
