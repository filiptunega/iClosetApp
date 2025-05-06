//
//  User.swift
//  iClosetApp
//
//  Created by Filip Tunega on 05/05/2025.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    var hasProfilePicture: Bool = false
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
            if let components = formatter.personNameComponents(from: username){
                formatter.style = .abbreviated
                return formatter.string(from: components)
            }
        return ""
        
    }
}
extension User {
    static var MOCK_USER = User(
        id: NSUUID().uuidString,
        username: "Filipko",
        email: "filip.tunega@icloud.com"
    )
}
