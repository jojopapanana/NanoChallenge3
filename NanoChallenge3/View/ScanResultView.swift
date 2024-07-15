//
//  ScanResultView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 11/07/24.
//

import SwiftUI
import SwiftData
import Vision

struct ScanResultView: View {

    @StateObject private var recognizeImage = recognizeText()
    
    var body: some View {
        VStack {
            Image(.reseppo)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button("Recognize") {
                recognizeImage.recognizeText()
            }
            
            VStack {
                Text("Full")
                List {
                    ForEach(recognizeImage.fullStringArr, id: \.self) { text in
                        Text(text)
                            .padding(.bottom, 5)
                    }
                }
                Text("Quantity")
                List {
                    ForEach(recognizeImage.qtyArr, id: \.self) { text in
                        Text(text)
                            .padding(.bottom, 5)
                    }
                }
                Text("Satuan")
                List {
                    ForEach(recognizeImage.satuanArr, id: \.self) { text in
                        Text(text)
                            .padding(.bottom, 5)
                    }
                }
                Text("Nama Bahan")
                List {
                    ForEach(recognizeImage.namaBahanArr, id: \.self) { text in
                        Text(text)
                            .padding(.bottom, 5)
                    }
                }
            }
        }
        .padding()
    }
    
}

#Preview {
    ScanResultView()
}





