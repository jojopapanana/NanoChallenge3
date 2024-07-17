import SwiftUI
import AVFoundation
import PhotosUI
import SwiftData

struct SelectedImageView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode

    @StateObject var camera = CameraModel()
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showImagePicker: Bool = false
    @State private var imageAttribute = ImageAttribute()
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var navigateToScanResult = false
    @State private var showPhotosPicker = false
    @State private var navigateToScanningView = false

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: InputRecipeFromPictView().environment(\.modelContext, modelContext), isActive: $navigateToScanResult) {
                    EmptyView()
                }
                NavigationLink(destination: ScanningView(), isActive: $navigateToScanningView) {
                    EmptyView()
                }
            }
            .padding()
            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    imageAttribute.image = data
                }
            }
            
            Spacer().frame(height: 40)

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
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.button)
                            
                            HStack{
                                Image(systemName: "photo")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                
                                Text("Choose Photo")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .foregroundStyle(Color.white)
                        }
                        .padding()
                        .frame(width: 361, height: 100)
                    }
                    
                    Spacer().frame(height: 10)

                    Button(action: {
                        removeImage()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            HStack {
                                Image(systemName: "trash")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                
                                Text("Discard Photo")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .foregroundStyle(Color.button)
                        }
                        .padding()

                    }
                }
            }
            
            Spacer().frame(height: 180)
        }
        .onAppear {
            DispatchQueue.main.async {
                showPhotosPicker = true
            }
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedPhoto, matching: .images)
        .onChange(of: showPhotosPicker) { newValue in
            if !newValue && selectedPhoto == nil {
                presentationMode.wrappedValue.dismiss()
            }
        }
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
