import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var image: Image? = nil
    @State private var uiImage: UIImage? = nil

    var onImagePicked: (UIImage) -> Void

    var body: some View {
        VStack {
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

            PhotosPicker(selection: $selectedItem, matching: .images) {
                Label("Choose Photo", systemImage: "photo")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("TextPrimary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImg = UIImage(data: data) {
                    self.uiImage = uiImg
                    self.image = Image(uiImage: uiImg)
                    self.onImagePicked(uiImg)
                }
            }
        }
    }
}
