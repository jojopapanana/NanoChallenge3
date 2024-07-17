//
//  ChooseInputView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI

struct ChooseInputView: View {
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
//        NavigationStack{
            VStack {
                NavigationLink{
                    ScanningView(usingCamera: true, navigationPath: $navigationPath)
                } label: {
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                                        Image(systemName: "camera.fill")
                                            .resizable()
                                            .frame(width: 88, height: 66)
                                            .foregroundColor(.white)
                                        Text("Scan")
                                            .fontWeight(.bold)
                                            .font(.largeTitle)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color(red: 1, green: 1, blue: 1))
                                    }
                            }
                            .frame(width: 361, height: 250)
                            .background(.button)
                            .cornerRadius(20)
                }
                
                Text("or")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .opacity(0.6)
                
                NavigationLink{
                    InputRecipeView(navigationPath: $navigationPath)
                } label: {
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                            Image(systemName: "pencil.and.list.clipboard.rtl")
                                .resizable()
                                .frame(width: 62, height: 66)
                                .foregroundColor(.button)
                            
                            Text("Manual")
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.button)
                        }
                    }
                    .frame(width: 361, height: 250)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .inset(by: 0.5)
                        .stroke(.button, lineWidth: 1)
                    )
                }
            }
            .navigationTitle("Input Recipe")
//        }
    }
}

//#Preview {
//    ChooseInputView()
//}
