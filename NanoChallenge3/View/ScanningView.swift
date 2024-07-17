import SwiftUI
import AVFoundation
import PhotosUI
import SwiftData
import Vision

struct ScanningView: View {
    var body: some View {
        NavigationView {
            CameraView()
        }
    }
}

struct CameraView: View {
    @Environment(\.modelContext) private var modelContext

    @StateObject var camera = CameraModel()
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var showImagePicker: Bool = false
    @State private var imageAttribute = ImageAttribute()
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var imageSelect: Bool = false
    @State private var navigateToScanResult = false
    @State private var navigateToSelectedImage = false
    @State private var showPhotosPicker = false
    @State private var navigateToCapturedImage = false
    @State private var isFlashlightOn = false
    @State private var currentZoomFactor: CGFloat = 1.0

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: SelectedImageView().environment(\.modelContext, modelContext), isActive: $navigateToSelectedImage) {
                    EmptyView()
                }
                NavigationLink(destination: CapturedImageView(imageAttribute: $imageAttribute).environment(\.modelContext, modelContext), isActive: $navigateToCapturedImage) {
                    EmptyView()
                }

            }
            .padding()

            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    imageAttribute.image = data
                    imageSelect = true
                }
            }
            
            Spacer().frame(height: 80)
            
            CameraPreview(camera: camera, currentZoomFactor: $currentZoomFactor).frame(height: UIScreen.main.bounds.height * 0.55)
            
            Spacer().frame(height: 40)

            Section {
                HStack {
                    Button(action: {
                        navigateToSelectedImage = true
                    }) {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .frame(width: 53.0, height: 53.0)
                            .foregroundColor(Color.button)
                    }

                    Spacer().frame(width: 60.0)

                    Button(action: {
                        camera.takePicture()
                    }) {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .frame(width: 53.0, height: 53.0)
                            .foregroundColor(Color.button)
                    }

                    Spacer().frame(width: 60.0)

                    Button(action: {
                        toggleFlashlight()
                    }) {
                        Image(systemName: isFlashlightOn ? "flashlight.on.circle" : "flashlight.off.circle")
                            .resizable()
                            .frame(width: 53.0, height: 53.0)
                            .foregroundColor(Color.button)
                    }
                    
                    
                }
                .padding()
                Spacer().frame(height: 180)
            }
            
        }
        .onAppear {
            camera.check()
            camera.isTaken = false
        }
        .onChange(of: camera.isTaken) { isTaken in
            if isTaken, let imageData = camera.capturedImageData {
                imageAttribute.image = cropImageToMatchFrameSize(imageData: imageData)
                navigateToCapturedImage = true
            }
        }
    }
    
    func toggleFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            if isFlashlightOn {
                device.torchMode = .off
                isFlashlightOn = false
            } else {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
                isFlashlightOn = true
            }
            device.unlockForConfiguration()
        } catch {
            print("Error toggling flashlight: \(error)")
        }
    }
    
    func cropImageToMatchFrameSize(imageData: Data) -> Data? {
        guard let uiImage = UIImage(data: imageData) else { return nil }
        let imageSize = uiImage.size
        let previewSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
        
        let widthRatio = previewSize.width / imageSize.width
        let heightRatio = previewSize.height / imageSize.height
        let scaleFactor = max(widthRatio, heightRatio)  // Use max instead of min to zoom in

        let scaledImageSize = CGSize(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
        let croppedRect = CGRect(x: (scaledImageSize.width - previewSize.width) / 2,
                                 y: (scaledImageSize.height - previewSize.height) / 2,
                                 width: previewSize.width,
                                 height: previewSize.height)

        UIGraphicsBeginImageContextWithOptions(previewSize, false, 1.0)
        uiImage.draw(in: CGRect(origin: CGPoint(x: -croppedRect.origin.x, y: -croppedRect.origin.y), size: scaledImageSize))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage?.jpegData(compressionQuality: 1.0)
    }

}

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var capturedImageData: Data?
    
    private var currentZoomFactor: CGFloat = 1.0

    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
        default:
            break
        }
    }

    func setUp() {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                self.session.beginConfiguration()

                guard let device = AVCaptureDevice.default(for: .video) else {
                    print("No camera available")
                    return
                }

                let input = try AVCaptureDeviceInput(device: device)

                if self.session.canAddInput(input) {
                    self.session.addInput(input)
                }

                if self.session.canAddOutput(self.output) {
                    self.session.addOutput(self.output)
                }

                self.session.commitConfiguration()

                DispatchQueue.main.async {
                    self.session.startRunning()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func takePicture() {
        let settings = AVCapturePhotoSettings()
        settings.isHighResolutionPhotoEnabled = false // Ensure the aspect ratio matches the preview
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        output.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }

        guard let imageData = photo.fileDataRepresentation() else {
            print("No image data found")
            return
        }

        DispatchQueue.main.async {
            self.capturedImageData = imageData
            self.isTaken = true
        }
    }

    func focus(at point: CGPoint) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        do {
            try device.lockForConfiguration()
            if device.isFocusPointOfInterestSupported {
                device.focusPointOfInterest = point
                device.focusMode = .continuousAutoFocus
            }
            if device.isExposurePointOfInterestSupported {
                device.exposurePointOfInterest = point
                device.exposureMode = .continuousAutoExposure
            }
            device.unlockForConfiguration()
        } catch {
            print("Error focusing: \(error)")
        }
    }
    
    func zoom(with factor: CGFloat) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        do {
            try device.lockForConfiguration()
            device.videoZoomFactor = factor
            device.unlockForConfiguration()
        } catch {
            print("Error zooming: \(error)")
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel
    @Binding var currentZoomFactor: CGFloat

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55))

        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.bounds
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch(_:)))
        view.addGestureRecognizer(pinchGesture)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CameraPreview

        init(_ parent: CameraPreview) {
            self.parent = parent
        }

        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let device = AVCaptureDevice.default(for: .video) else { return }

            let maxZoomFactor = device.activeFormat.videoMaxZoomFactor
            let pinchVelocityDividerFactor: CGFloat = 5.0

            if gesture.state == .changed {
                let desiredZoomFactor = parent.currentZoomFactor + atan2(gesture.velocity, pinchVelocityDividerFactor)
                parent.currentZoomFactor = max(1.0, min(desiredZoomFactor, maxZoomFactor))
                parent.camera.zoom(with: parent.currentZoomFactor)
            }
        }
    }
}
