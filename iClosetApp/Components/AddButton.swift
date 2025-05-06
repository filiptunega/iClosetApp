//
//  AddButton.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//


import SwiftUI

struct AddButton: View {
    var body: some View {
        Button(action: {
            // Add new item
        }) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color("TextPrimary"))
                .clipShape(Circle())
                .shadow(radius: 4)
        }
        .padding()
    }
}