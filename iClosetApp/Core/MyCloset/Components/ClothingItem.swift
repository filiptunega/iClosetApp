import FirebaseFirestore
import Foundation

struct ClothingItem: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var name: String
    var type: String
    var color: String
    var brand: String?
    var imageUrl: String
    var description: String
    var createdAt: Timestamp?
}
