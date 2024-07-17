import SwiftUI
import SwiftData
import Vision

struct ScanResultView: View {
@Environment(\.modelContext) private var modelContext
@State private var imageAttributes: ImageAttribute?

@StateObject private var recognizeImage = recognizeText()

var body: some View {
    VStack {
        if let imageData = imageAttributes?.image,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.height * 0.45)
        } else {
            Text("No image available")
        }
        
        Button("Recognize") {
            recognizeImage.modelContext = modelContext
            recognizeImage.imageAttributes = imageAttributes
            recognizeImage.recognizeText()
        }
  
            
//                VStack {
//                    Text("Full")
//                    List {
//                        ForEach(recognizeImage.fullStringArr, id: \.self) { text in
//                            Text(text)
//                                .padding(.bottom, 5)
//                        }
//                    }
//                    Text("Quantity")
//                    List {
//                        ForEach(recognizeImage.qtyArr, id: \.self) { text in
//                            Text(text)
//                                .padding(.bottom, 5)
//                        }
//                    }
//                    Text("Satuan")
//                    List {
//                        ForEach(recognizeImage.satuanArr, id: \.self) { text in
//                            Text(text)
//                                .padding(.bottom, 5)
//                        }
//                    }
//                    Text("Nama Bahan")
//                    List {
//                        ForEach(recognizeImage.namaBahanArr, id: \.self) { text in
//                            Text(text)
//                                .padding(.bottom, 5)
//                        }
//                    }
//                }
        }
        .padding()
    }
}

