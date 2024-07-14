//
//  ChooseInputView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI

struct ChooseInputView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 20) {
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                                    Image(systemName: "camera.fill")
                                        .resizable()
                                        .frame(width: 88, height: 66)
                                        .foregroundColor(.white)
                                    Text("Scan")
                                        .font(
                                            Font.custom("SF Pro", size: 39)
                                                .weight(.bold)
                                        )
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 1, green: 1, blue: 1))
                                }
                        }
                        .frame(width: 361, height: 250)
                        .background(Color(red: 1, green: 0.22, blue: 0.36))
                        .cornerRadius(20)
                
                Text("or")
                    .font(Font.custom("SF Pro", size: 32))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26))
                    .opacity(0.6)
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                                    Image(systemName: "pencil.and.list.clipboard.rtl")
                                        .resizable()
                                        .frame(width: 62, height: 66)
                                        .foregroundColor(Color(red: 1, green: 0.22, blue: 0.36))
                                    Text("Manual")
                                    .font(
                                    Font.custom("SF Pro", size: 39)
                                    .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 1, green: 0.22, blue: 0.36))
                                }
                        }
                        .frame(width: 361, height: 250)
                        .cornerRadius(20)
                        .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .inset(by: 0.5)
                        .stroke(Color(red: 1, green: 0.22, blue: 0.36), lineWidth: 1)
                        )
            
            }
            .padding(0)
            .frame(width: 361, alignment: .center)
            .navigationTitle("Input Recipe")
        }
    }
}

#Preview {
    ChooseInputView()
}
