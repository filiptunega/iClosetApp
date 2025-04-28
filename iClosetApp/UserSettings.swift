import SwiftUI

class UserSettings: ObservableObject {
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var isLoggedIn: Bool = false
}
