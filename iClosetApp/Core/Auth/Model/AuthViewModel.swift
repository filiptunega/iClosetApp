//
//  SwiftUIView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 05/05/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreCombineSwift

protocol AuthIsCorrect{
    var formIsCorrect: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    init(){
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email,
                                                      password: password)
            self.userSession = result.user
            await fetchUser()
        }
        catch{
            print ("DEBUG: Failed to log in \(error.localizedDescription) :(")
        }
    }
    func CreateUser (withEmail email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, username: username, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
            await fetchUser()
            
        }
        catch{
            print("DEBUG: Failed to create user \(error.localizedDescription) :(")
        }
    }
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        catch {
            print("DEBUG: Failed to sign out \(error.localizedDescription) :(")
        }
    }
    func deleteAccount() async throws {
        
    }
    func fetchUser() async {
        guard let uid = self.userSession?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("DEBUG: Current user is \(String(describing: self.currentUser))")
        
    }
}
