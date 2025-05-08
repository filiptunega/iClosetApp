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
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                header
                imagePreview
                photoPickerButton
                cameraButton
                continueButton
            }
            .padding(.vertical)
        }
        .onChange(of: selectedItem) {
            Task {
                await loadImageFromPicker()
            }
        }
    }

    // MARK: - Header
    private var header: some View {
        Text("Add a Photo")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color("TextPrimary"))
            .padding(.top)
    }

    // MARK: - Image Preview
    private var imagePreview: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .padding()
                    .background(Color("CardBackground"))
                    .cornerRadius(12)
                    .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)
            } else {
                Rectangle()
                    .fill(Color("Labels").opacity(0.2))
                    .frame(height: 250)
                    .overlay(
                        Text("No image selected")
                            .foregroundColor(Color("TextSecondary"))
                            .font(.subheadline)
                    )
                    .cornerRadius(12)
                    .padding()
            }
        }
    }

    // MARK: - Photo Picker Button
    private var photoPickerButton: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            Label("Choose Photo", systemImage: "photo")
                .modifier(ActionButtonStyle(
                    isPrimary: uiImage == nil,
                    labelColor: uiImage == nil ? Color("Picker1") : Color("TextPrimary"),
                    backgroundColor: uiImage == nil ? Color("Labels") : .clear
                ))
        }
        .padding(.horizontal)
    }

    // MARK: - Camera Button
    private var cameraButton: some View {
        Button {
            showCamera = true
        } label: {
            Label("Take Photo", systemImage: "camera")
                .modifier(ActionButtonStyle(
                    isPrimary: uiImage == nil,
                    labelColor: uiImage == nil ? Color("Picker1") : Color("TextPrimary"),
                    backgroundColor: uiImage == nil ? Color("Labels") : .clear
                ))
        }
        .sheet(isPresented: $showCamera) {
            CameraView { takenImage in
                self.uiImage = takenImage
                self.image = Image(uiImage: takenImage)
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Continue Button
    private var continueButton: some View {
        Button {
            if let uiImage = uiImage {
                onImagePicked(uiImage)
            }
        } label: {
            Text("Continue")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(uiImage != nil ? Color("Labels") : Color("Labels").opacity(0.3))
                .foregroundColor(Color("Picker1"))
                .cornerRadius(10)
                .padding(.horizontal)
                .opacity(uiImage != nil ? 1 : 0.6)
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

// MARK: - Button Modifier
struct ActionButtonStyle: ViewModifier {
    var isPrimary: Bool
    var labelColor: Color
    var backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("TextPrimary"), lineWidth: isPrimary ? 0 : 2)
            )
            .foregroundColor(labelColor)
            .cornerRadius(10)
    }
}

// MARK: - Preview
#Preview {
    ImagePickerView(onImagePicked: { _ in })
}
