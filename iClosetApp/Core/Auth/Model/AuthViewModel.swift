//
//  SwiftUIView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 05/05/2025.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    init(){
        
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        print("Logging in")
    }
    func CreateUser (withEmail email: String, password: String, username: String) async throws {
        print("Singing up")
    }
    func signOut() async throws {
        
    }
    func deleteAccount() async throws {
        
    }
    func fetchUser() async {
        
    }
}
