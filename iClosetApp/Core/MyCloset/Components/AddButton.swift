//
//  AddButton.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//


import SwiftUI

struct AddButton: View {
    
    @Binding var showAddClothing: Bool
    
    var body: some View {
        Button(action: {
            showAddClothing = true
        }) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color("Labels"))
                .clipShape(Circle())
                .shadow(radius: 4)
        }
        .padding()
    }
}
