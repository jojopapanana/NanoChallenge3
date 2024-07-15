//
//  recognizeText.swift
//  NanoChallenge3
//
//  Created by Hans Zebua on 15/07/24.
//

import Foundation
import UIKit
import Vision

class recognizeText: ObservableObject {
    
    @Published var fullStringArr: [String] = []
    @Published var qtyArr: [String] = []
    @Published var satuanArr: [String] = []
    @Published var namaBahanArr: [String] = []
    
    func recognizeText() {
        // ngambil image
        let image = UIImage(resource: .reseppo)
        
        // dicek ada isinya gak
        guard let cgImage = image.cgImage else { return }
        
        // manggil VNImageRequestHandler yang fungsinya utk mem-process gambar
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        // manggil VNRecognizeTextRequest yang fungsinya buat recognize text yg ada di gambar
        let request = VNRecognizeTextRequest { request, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            // kita typecast hasil result ke bentuk VNRecognizedTextObservation
            guard let result = request.results as? [VNRecognizedTextObservation] else {
                return
            }
            
            // simpen hasilnya di array, terus isi tiap row nanti adalah hasil recognition dengan confidences terbaik
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
            
            // Use 'self' to indicate that these properties belong to the instance of ScanResultView
            DispatchQueue.main.async {
                self.fullStringArr = processedText
                self.qtyArr = qtyArr
                self.satuanArr = satuanArr
                self.namaBahanArr = namaBahanArr
            }
        }
        
        // set recognitionnya accurate
        request.recognitionLevel = .accurate
        
        // panggil handler api image-to-text
        do {
            try handler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }

}
