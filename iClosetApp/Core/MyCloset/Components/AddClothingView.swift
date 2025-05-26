import SwiftUI
import FirebaseFirestore

struct AddClothingView: View {
    @State private var selectedImage: UIImage?
    @State private var uploadedImageUrl: URL?
    @State private var analyzedItem: ClothingItem?
    @State private var isNavigating = false

    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                ImagePickerView { image in
                    self.selectedImage = image
                    handleImageUpload(image)
                }

                if selectedImage != nil {
                    ProgressView("Analyzing image...")
                        .padding()
                }

                Spacer()
            }
            .navigationDestination(isPresented: $isNavigating) {
                if let image = selectedImage,
                   let url = uploadedImageUrl,
                   let userId = viewModel.currentUser?.id,
                   let item = analyzedItem {
                    AnalyzingClothingView(image: image, imageUrl: url, userId: userId, item: item)
                } else {
                    Text("Unexpected error. Try again.")
                }
            }
            .navigationTitle("Add Item")
        }
    }

    private func handleImageUpload(_ image: UIImage) {
        guard let userId = viewModel.currentUser?.id else {
            print("User not found")
            return
        }

        ImageUploader.uploadImage(image, userId: userId) { result in
            switch result {
            case .success(let url):
                print("✅ Image uploaded at URL: \(url.absoluteString)")
                self.uploadedImageUrl = url

                analyzeClothingImage(imageURL: url.absoluteString) { item in
                    DispatchQueue.main.async {
                        if let item = item {
                            self.analyzedItem = item
                            self.isNavigating = true
                        } else {
                            print("❌ Failed to analyze image")
                        }
                    }
                }

            case .failure(let error):
                print("❌ Upload error: \(error.localizedDescription)")
            }
        }
    }

    private func analyzeClothingImage(imageURL: String, completion: @escaping (ClothingItem?) -> Void) {
        let apiKey = "AIzaSyBh08A4xhfDPT6aEl6ct-rmhCszNuNrJ_A"
        let endpoint = "https://vision.googleapis.com/v1/images:annotate?key=\(apiKey)"

        let requestBody: [String: Any] = [
            "requests": [[
                "image": ["source": ["imageUri": imageURL]],
                "features": [
                    ["type": "LABEL_DETECTION", "maxResults": 5],
                    ["type": "IMAGE_PROPERTIES"],
                    ["type": "TEXT_DETECTION"]
                ]
            ]]
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }

            if let result = try? JSONDecoder().decode(GoogleVisionResponse.self, from: data) {
                let label = result.responses.first?.labelAnnotations?.first?.description ?? "Clothing"
                let colorRGB = result.responses.first?.imagePropertiesAnnotation?.dominantColors.colors.first?.color
                let brandText = result.responses.first?.textAnnotations?.first?.description

                let color = colorRGB?.closestBasicColorName() ?? "Unknown"

                let item = ClothingItem(
                    id: UUID().uuidString,
                    userId: viewModel.currentUser?.id ?? "unknown",
                    name: label,
                    type: label,
                    color: color,
                    brand: brandText,
                    imageUrl: imageURL,
                    description: "Detected \(label.lowercased()) in \(color.lowercased()) color",
                    createdAt: Timestamp(date: Date())
                )

                completion(item)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

// MARK: - Vision API Structs

struct GoogleVisionResponse: Codable {
    let responses: [VisionResponse]
}

struct VisionResponse: Codable {
    let labelAnnotations: [LabelAnnotation]?
    let imagePropertiesAnnotation: ImagePropertiesAnnotation?
    let textAnnotations: [TextAnnotation]?
}

struct LabelAnnotation: Codable {
    let description: String
}

struct ImagePropertiesAnnotation: Codable {
    let dominantColors: DominantColors
}

struct DominantColors: Codable {
    let colors: [ColorInfo]
}

struct ColorInfo: Codable {
    let color: RGBColor
}

struct RGBColor: Codable {
    let red: Double?
    let green: Double?
    let blue: Double?

    func closestBasicColorName() -> String {
        guard let r = red, let g = green, let b = blue else { return "Nezoskenovalo sa" }

        let red255 = Int(r * 255)
        let green255 = Int(g * 255)
        let blue255 = Int(b * 255)

        print("RGB: \(red255), \(green255), \(blue255)")

        if red255 > 200 && green255 > 200 && blue255 > 200 { return "White" }
        if red255 < 50 && green255 < 50 && blue255 < 50 { return "Black" }
        if red255 > green255 && red255 > blue255 { return "Red" }
        if green255 > red255 && green255 > blue255 { return "Green" }
        if blue255 > red255 && blue255 > green255 { return "Blue" }
        return "Unknown"
    }
}

struct TextAnnotation: Codable {
    let description: String
}
