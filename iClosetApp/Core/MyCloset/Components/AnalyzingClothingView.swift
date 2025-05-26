import SwiftUI
import FirebaseFirestore

struct AnalyzingClothingView: View {
    // MARK: - Properties

    let image: UIImage
    let imageUrl: URL
    let userId: String
    let initialItem: ClothingItem
    @Environment(\.dismiss) var dismiss

    @State private var name: String
    @State private var type: String
    @State private var color: String
    @State private var brand: String

    private let clothingTypes = ["T-Shirt", "Shirt", "Pants", "Jacket", "Sweater", "Shorts", "Shoes", "Accessory"]
    private let colors = ["Black", "White", "Gray", "Blue", "Red", "Green", "Yellow", "Beige", "Brown", "Pink", "Purple", "Orange"]

    // MARK: - Init

    init(image: UIImage, imageUrl: URL, userId: String, item: ClothingItem) {
        self.image = image
        self.imageUrl = imageUrl
        self.userId = userId
        self.initialItem = item
        _name = State(initialValue: item.name)
        _type = State(initialValue: item.type)
        _color = State(initialValue: item.color)
        _brand = State(initialValue: item.brand ?? "")
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            VStack(spacing: 16) {
                // MARK: Image Preview
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .padding()
                    .background(Color("CardBackground"))
                    .cornerRadius(12)
                    .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)

                // MARK: Form Fields
                List {
                    Section {
                        TextField("Name", text: $name)

                        Picker("Type", selection: $type) {
                            ForEach(clothingTypes, id: \.self) {
                                Text($0)
                            }
                        }

                        Picker("Color", selection: $color) {
                            ForEach(colors, id: \.self) {
                                Text($0)
                            }
                        }

                        TextField("Brand", text: $brand)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("Background"))

                // MARK: Save Button
                Button(action: saveItem) {
                    Text("Save to Closet")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Labels"))
                        .foregroundColor(Color("Picker1"))
                        .cornerRadius(10)
                        .shadow(color: Color("ShadowColor"), radius: 2, x: 0, y: 1)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("Review & Save")
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Methods

    private func saveItem() {
        let db = Firestore.firestore()
        var data: [String: Any] = [
            "imageUrl": imageUrl.absoluteString,
            "userId": userId,
            "createdAt": Timestamp(),
            "name": name,
            "type": type,
            "color": color
        ]
        if !brand.isEmpty {
            data["brand"] = brand
        }

        db.collection("clothingItems").addDocument(data: data) { error in
            if let error = error {
                print("❌ Firestore save failed: \(error.localizedDescription)")
            } else {
                print("✅ Clothing item saved.")
                DispatchQueue.main.async {
                    dismiss()
                    dismiss()
                    dismiss()
                }
            }
        }
    }
}
