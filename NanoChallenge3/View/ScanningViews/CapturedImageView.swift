import SwiftUI
import AVFoundation
import PhotosUI
import SwiftData

struct CapturedImageView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var imageAttribute: ImageAttribute

    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showImagePicker: Bool = false
//    @State private var selectedPhoto: PhotosPickerItem?
    @State private var navigateToScanResult = false
    @Binding var navigationPath:NavigationPath

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: InputRecipeFromPictView(navigationPath:$navigationPath).environment(\.modelContext, modelContext), isActive: $navigateToScanResult) {
                    EmptyView()
                }
            }
            .padding()
//            .task(id: selectedPhoto) {
//                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
//                    imageAttribute.image = data
//                }
//            }

            Section {
                if let imageData = imageAttribute.image,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.main.bounds.height * 0.55)
                }

                if imageAttribute.image != nil {
                    Button(action: {
                        handleImage()
                    }) {
                        Label("Select photo", systemImage: "photo")
                    }

                    Button(role: .destructive) {
                        removeImage()
                        
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Discard Image", systemImage: "trash")
                    }
                    
                }
            }
        }
        .onAppear { }
    }

    private func removeImage() {
        DispatchQueue.main.async {
            withAnimation {
//                selectedPhoto = nil
                imageAttribute.image = nil
            }
        }
    }

    private func handleImage() {
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
    }
}
