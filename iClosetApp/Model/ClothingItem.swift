//
//  ClothingItem.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//


import Foundation

struct ClothingItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
}