import Foundation
import UIKit
import Vision
import SwiftData

class recognizeText: ObservableObject {
    @Published var fullStringArr: [String] = []
    @Published var qtyArr: [String] = []
    @Published var satuanArr: [String] = []
    @Published var namaBahanArr: [String] = []

    var modelContext: ModelContext?
    var imageAttributes: ImageAttribute?

    func recognizeText() {
        guard let modelContext = modelContext else { return }
        
        // Fetch the most recent ImageAttribute if not provided
        if imageAttributes == nil {
            let fetchRequest = FetchDescriptor<ImageAttribute>()
            if let fetchedAttributes = try? modelContext.fetch(fetchRequest) {
                imageAttributes = fetchedAttributes.last
            }
        }
        
        guard let imageData = imageAttributes?.image,
              let image = UIImage(data: imageData),
              let cgImage = image.cgImage else { return }

        // Create VNImageRequestHandler to process the image
        let handler = VNImageRequestHandler(cgImage: cgImage)

        // Create VNRecognizeTextRequest to recognize text in the image
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            // Cast results to VNRecognizedTextObservation
            guard let result = request.results as? [VNRecognizedTextObservation] else {
                return
            }

            // Store the recognition results in an array
            let recogArr = result.compactMap { result in
                result.topCandidates(1).first?.string
            }

            // Process the recogArr to join lines that don't start with a numerical character
            var processedText: [String] = []
            for text in recogArr {
                if let last = processedText.last, !text.prefix(1).contains(where: { $0.isNumber }) {
                    processedText[processedText.count - 1] = last + " " + text
                } else {
                    processedText.append(text)
                }
            }

            // Split processedText into qtyArr, satuanArr, and namaBahanArr
            var qtyArr: [String] = []
            var satuanArr: [String] = []
            var namaBahanArr: [String] = []

            for text in processedText {
                let components = text.split(separator: " ")
                if components.count >= 3 {
                    qtyArr.append(String(components[0]))
                    satuanArr.append(String(components[1]))
                    namaBahanArr.append(components.dropFirst(2).joined(separator: " "))
                }
            }

            // Update published properties
            DispatchQueue.main.async {

                self.fullStringArr = processedText
                self.qtyArr = qtyArr
                self.satuanArr = satuanArr
                self.namaBahanArr = namaBahanArr
            }
        }

        // Set recognition level to accurate
        request.recognitionLevel = .accurate

        // Perform the image-to-text request
        do {
            try handler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
}
// Use 'self' to indicate that these properties belong to the instance of ScanResultView

