import Foundation
import FirebaseStorage
import UIKit

struct ImageUploader {
    static func uploadImage(_ image: UIImage, userId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.pngData() else {
            completion(.failure(NSError(domain: "ImageConversion", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert UIImage to data."])))
            return
        }

        let fileRef = Storage.storage().reference().child("clothes/\(userId)/\(UUID().uuidString).png")

        fileRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            fileRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                }
            }
        }
    }
}