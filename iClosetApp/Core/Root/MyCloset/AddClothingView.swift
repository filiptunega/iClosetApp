//
//  AddItemSheetView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//


import SwiftUI
import FirebaseStorage

struct AddClothingView: View {
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            ImagePickerView { image in
                selectedImage = image
                // Tu môžeš uložiť obrázok do databázy alebo array
            }

            Spacer()
        }
        .navigationTitle("Add Item")
    }
}
#Preview {
    AddClothingView()
}
