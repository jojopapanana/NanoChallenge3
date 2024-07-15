//
//  ScanInstructions.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 14/07/24.
//

import SwiftUI

struct ScanInstructions: View {
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment:.leading){
                    Text("1. Click start button")
                    .font(
                    Font.custom("SF Pro", size: 26)
                    .weight(.bold)
                    )
                    Text("Click the insert recipe button below to add a recipe using the camera.")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.light)
                    )
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 41)
                    .padding(.top, 12)
                }
                .padding()
                VStack(alignment:.leading){
                    Text("2. Allow access camera")
                    .font(
                    Font.custom("SF Pro", size: 26)
                    .weight(.bold)
                    )
                    Text("Approve camera access to take a picture of the recipe.")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.light)
                    )
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 41)
                    .padding(.top, 12)
                }
                .padding()
                VStack(alignment:.leading){
                    Text("3. Scan recipe ingredients")
                    .font(
                    Font.custom("SF Pro", size: 26)
                    .weight(.bold)
                    )
                    Text("Take photos focusing only on ingredients for easier scanning.")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.light)
                    )
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 41)
                    .padding(.top, 12)
                }
                .padding()
                Spacer()
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
                .background(Color(red: 1, green: 0.22, blue: 0.36))

                .cornerRadius(12)
            }
            .padding()
            .navigationTitle("Instructions")
        }
    }
}

#Preview {
    ScanInstructions()
}
