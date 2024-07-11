//
//  CapturedImage.swift
//  NanoChallenge3
//
//  Created by Geraldo Pannanda Lutan on 12/07/24.
//

import SwiftUI
import AVFoundation
import PhotosUI
import SwiftData

struct SelectedImageView: View {
    @Environment(\.modelContext) private var modelContext

    @StateObject var camera = CameraModel()
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showImagePicker: Bool = false
    @State private var imageAttribute = ImageAttribute()
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var navigateToScanResult = false
    @State private var showPhotosPicker = false

    var body: some View {
        VStack {

            HStack {
                NavigationLink(destination: StoredImageView().environment(\.modelContext, modelContext), isActive: $navigateToScanResult) {
                    EmptyView()
                }
                    
            }
            .padding()
            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    imageAttribute.image = data
                    
                }
            }
            
            Section {
                if let imageData = imageAttribute.image,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.height * 0.65)
                }

                if selectedPhoto != nil && imageAttribute.image != nil {
                    Button(action: {
                        // Fetch existing ImageAttribute objects
                        let fetchRequest = FetchDescriptor<ImageAttribute>()
                        if let fetchedAttributes = try? modelContext.fetch(fetchRequest) {

                            // Delete all existing ImageAttribute objects
                            for attribute in fetchedAttributes {
                                modelContext.delete(attribute)
                            }

                        }

                        // Create a new item with the new image
                        let newItem = ImageAttribute()
                        newItem.image = imageAttribute.image

                        // Append the new item to the existing ones
                        modelContext.insert(newItem)
                        
                        navigateToScanResult = true

                    }) {
                        Label("Select photo", systemImage: "photo")
                    }

                    Button(role: .destructive) {
                        removeImage()
                        
                        showPhotosPicker = true
                    } label: {
                        Label("Change Image", systemImage: "trash")
                            
                    }.photosPicker(isPresented: $showPhotosPicker, selection: $selectedPhoto, matching: .images)

                }

            }
        }
        .onAppear {
            showPhotosPicker = true
            
        }.photosPicker(isPresented: $showPhotosPicker, selection: $selectedPhoto, matching: .images)

    }

    private func removeImage() {
        DispatchQueue.main.async {
            withAnimation {
                selectedPhoto = nil
                imageAttribute.image = nil
                
            }
        }
    }
    
    
}


