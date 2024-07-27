//
//  progressBar.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 27/07/24.
//

import SwiftUI

struct progressBar: View {
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 300, height: 2)
              .background(Color(red: 0.76, green: 0.76, blue: 0.76))
            
            HStack{
                VStack(alignment: .center, spacing: 4) {
                    Text("1")
                        .fontWeight(.semibold)
                        .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .frame(width: 40, height: 40, alignment: .center)
                .background(.button)
                .cornerRadius(20)

                Spacer()

                VStack(alignment: .center, spacing: 4) {
                    Text("2")
                        .fontWeight(.semibold)
                        .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .frame(width: 40, height: 40, alignment: .center)
                .background(.progressBarInactive)
                .cornerRadius(20)

                Spacer()

                VStack(alignment: .center, spacing: 4) {
                    Text("3")
                        .fontWeight(.semibold)
                        .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .frame(width: 40, height: 40, alignment: .center)
                .background(.progressBarInactive)
                .cornerRadius(20)
            }
            .frame(width: 320, height: 2)
        }
    }
}

#Preview {
    progressBar()
}
