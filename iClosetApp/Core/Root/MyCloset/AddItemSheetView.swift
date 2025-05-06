//
//  AddItemSheetView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//


import SwiftUI
import FirebaseStorage

struct AddItemSheetView: View {
    @Binding var isPresented: Bool
    @State private var showCamera = true // hneď otvorí fotoaparát
    @State private var image: UIImage?
    @State private var uploadURL: URL?
    @State private var itemName = ""

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                TextField("Item name", text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Uložiť položku") {
                    // Tu môžeš uložiť názov + URL do Firestore
                    print("Uklada sa: \(itemName), url: \(uploadURL?.absoluteString ?? "")")
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)

            } else {
                Text("Čakám na fotku...")
                    .foregroundColor(.gray)
            }
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $image)
        }
        .onChange(of: image) { newImage in
            if let newImage = newImage {
                uploadImageToFirebase(image: newImage)
            }
        }
        .padding()
    }

    func uploadImageToFirebase(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference().child("closet/\(filename).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("❌ Upload failed: \(error.localizedDescription)")
                return
            }

            storageRef.downloadURL { url, error in
                if let url = url {
                    uploadURL = url
                    print("✅ Uploaded: \(url)")
                }
            }
        }
    }
}
