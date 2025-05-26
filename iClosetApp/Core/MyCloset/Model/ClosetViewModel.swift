import FirebaseFirestore
import SwiftUI
import Combine
import Foundation

class ClosetViewModel: ObservableObject {
    @Published var clothes: [ClothingItem] = []
    private var db = Firestore.firestore()

    func fetchClothes(for userId: String) {
        db.collection("clothingItems")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments(source: .server) { [weak self] snapshot, error in
                if let error = error {
                    print("❌ Firestore fetch error: \(error.localizedDescription)")
                    return
                }
                
                self?.clothes = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: ClothingItem.self)
                } ?? []
            }
    }
}
