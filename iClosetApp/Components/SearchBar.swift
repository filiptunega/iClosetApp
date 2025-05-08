//
//  SearchBar.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//


import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search...", text: $text)
            .padding(10)
            .background(Color("CardBackground"))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 8)
    }
}
