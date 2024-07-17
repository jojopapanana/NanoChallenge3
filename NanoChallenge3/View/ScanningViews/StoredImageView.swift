//
//  StoredImageView.swift
//  NanoChallenge3
//
//  Created by Geraldo Pannanda Lutan on 15/07/24.
//

import SwiftUI
import SwiftData

struct StoredImageView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var imageAttributes: ImageAttribute?

    
    var body: some View {
        VStack {
            
            if let imageData = imageAttributes?.image,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.65)
            } else {
                Text("No image available")
            }
            
        }
        .onAppear {
            loadImageAttribute()
        }
        
        
    }
    
    private func loadImageAttribute() {
        // Fetch the most recent ImageAttribute
        let fetchRequest = FetchDescriptor<ImageAttribute>()
        if let fetchedAttributes = try? modelContext.fetch(fetchRequest) {
            imageAttributes = fetchedAttributes.last
        }
    }
    
}
