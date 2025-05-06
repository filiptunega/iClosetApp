//
//  ClothingCardView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//
import SwiftUI


struct ClothingCardView: View {
    let item: ClothingItem
    let isEditing: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipped()
                .cornerRadius(12)

            Text(item.name)
                .font(.headline)
                .foregroundColor(Color("TextPrimary"))

            Text(item.description)
                .font(.caption)
                .foregroundColor(.gray)

            if isEditing {
                Button(action: {
                    // handle edit
                }) {
                    Label("Edit", systemImage: "pencil")
                        .font(.caption)
                        .foregroundColor(Color("TextPrimary"))
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.95))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
