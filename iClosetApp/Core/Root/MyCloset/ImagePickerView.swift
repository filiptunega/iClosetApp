import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    // MARK: - Properties
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var image: Image? = nil
    @State private var uiImage: UIImage? = nil
    @State private var showCamera = false

    var onImagePicked: (UIImage) -> Void

    // MARK: - View
    var body: some View {
        VStack(spacing: 16) {
            header
            imagePreview
            photoPickerButton
            cameraButton
            continueButton
        }
        .navigationTitle("Choose Photo")
        .padding(.vertical)
        .background(Color("Background"))
        .onChange(of: selectedItem) {
            Task {
                await loadImageFromPicker()
            }
        }
    }

    // MARK: - Subviews
    private var header: some View {
        Text("Add a Photo")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color("TextPrimary"))
            .padding(.top)
    }

    private var imagePreview: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .padding()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 250)
                    .overlay(
                        Text("No image selected")
                            .foregroundColor(.gray)
                    )
                    .cornerRadius(12)
                    .padding()
            }
        }
    }

    private var photoPickerButton: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            Label("Choose Photo", systemImage: "photo")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(uiImage == nil ? Color("TextPrimary") : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("TextPrimary"), lineWidth: 2)
                )
                .foregroundColor(uiImage == nil ? .white : Color("TextPrimary"))
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }

    private var cameraButton: some View {
        Button(action: {
            showCamera = true
        }) {
            Label("Take Photo", systemImage: "camera")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(uiImage == nil ? Color("TextPrimary") : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("TextPrimary"), lineWidth: 2)
                )
                .foregroundColor(uiImage == nil ? .white : Color("TextPrimary"))
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .sheet(isPresented: $showCamera) {
            CameraView { takenImage in
                self.uiImage = takenImage
                self.image = Image(uiImage: takenImage)
            }
        }
    }

    private var continueButton: some View {
        Button(action: {
            if let uiImage = uiImage {
                onImagePicked(uiImage)
            }
        }) {
            Text("Continue")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(uiImage != nil ? Color("TextPrimary") : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .opacity(uiImage != nil ? 1 : 0.5)
        }
        .disabled(uiImage == nil)
    }

    // MARK: - Helpers
    private func loadImageFromPicker() async {
        if let data = try? await selectedItem?.loadTransferable(type: Data.self),
           let uiImg = UIImage(data: data) {
            self.uiImage = uiImg
            self.image = Image(uiImage: uiImg)
        }
    }
}
