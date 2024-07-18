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
                NavigationLink(destination: InputRecipeFromPictView(navigationPath: $navigationPath).environment(\.modelContext, modelContext), isActive: $navigateToScanResult) {
                    EmptyView()
                }
            }
            .padding()
            
            Spacer().frame(height: 40)

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
                    
                    
                    //                        ZStack{
                    //
                    //                            HStack{
                    //                                Image(systemName: "trash")
                    //                                    .font(.title)
                    //                                    .fontWeight(.semibold)
                    //
                    //                                Text("Discard Photo")
                    //                                    .fontWeight(.semibold)
                    //                                    .font(.title2)
                    //                            }
                    //                            .border(Color.button)
                    ////                            .foregroundStyle(Color.button)
                    //                        }
                    //                        .padding()
                    //                        .frame(width: 361, height: 100)
                    //                        .overlay(
                    //                            RoundedRectangle(cornerRadius: 20)
                    //                                .inset(by: 0.5)
                    //                            .stroke(.button, lineWidth: 1)
                    //                        )
                }
            }
            
            Spacer().frame(height: 120)
        }
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
