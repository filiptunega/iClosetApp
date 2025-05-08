import SwiftUI
import FirebaseFirestore

struct AddClothingView: View {
    // MARK: - Properties
    @State private var selectedImage: UIImage?
    @EnvironmentObject var viewModel: AuthViewModel
    
    // MARK: - View
    var body: some View {
        VStack {
            ImagePickerView { image in
                self.selectedImage = image
                handleImageUpload(image)
            }

            Spacer()
        }
        .navigationTitle("Add Item")
    }
    
    // MARK: - Methods
    private func handleImageUpload(_ image: UIImage) {
        guard let userId = viewModel.currentUser?.id else {
            print("User not found")
            return
        }
        
        ImageUploader.uploadImage(image, userId: userId) { result in
            switch result {
            case .success(let url):
                print("Image uploaded at URL: \(url.absoluteString)")
                saveImageURLToFirestore(url, userId: userId)
            case .failure(let error):
                print("Upload error: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveImageURLToFirestore(_ url: URL, userId: String) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "imageUrl": url.absoluteString,
            "userId": userId,
            "createdAt": Timestamp()
        ]
        
        db.collection("clothingItems").addDocument(data: data) { error in
            if let error = error {
                print("Failed to save image URL to Firestore: \(error.localizedDescription)")
            } else {
                print("Image URL saved to Firestore successfully.")
            }
        }
    }
}
