import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false
    @State private var isRegistered: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray4)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    // "Sign Up" Text na vrchu
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)
                    
                    // Formulár s poliami
                    VStack(spacing: 16) {
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .textContentType(.password)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    // Chybová správa
                    Text(errorMessage)
                        .foregroundColor(.red)
                    
                    // Zobrazenie indikátora načítania
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .padding()
                    }
                    
                    // Tlačidlo pre registráciu
                    Button(action: {
                        registerUser()
                    }) {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Preklik na LoginPage
                    NavigationLink("Already have an account? Log In", destination: LoginView())
                        .padding(.bottom, 20)
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func registerUser() {
        // Zkontroluj, či sa heslá zhodujú
        if password != confirmPassword {
            errorMessage = "Passwords do not match!"
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        // Vytvor používateľa v Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            isLoading = false
            
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
                return
            }
            
            // Ulož používateľské údaje do Firestore
            let db = Firestore.firestore()
            
            // Používame email ako Document ID (email premenený na bezpečný formát)
            let sanitizedEmail = sanitizeEmail(email)
            let userRef = db.collection("users").document(sanitizedEmail)
            
            let userData: [String: Any] = [
                "username": username,
                "email": email
            ]
            
            userRef.setData(userData) { error in
                if let error = error {
                    errorMessage = "Error saving user data: \(error.localizedDescription)"
                } else {
                    print("User data saved successfully")
                    // Nastavenie premennej isRegistered na true, aby sa zobrazil HomeView
                    isRegistered = true
                }
            }
        }
    }
    
    func sanitizeEmail(_ email: String) -> String {
        return email.replacingOccurrences(of: "@", with: "_at_").replacingOccurrences(of: ".", with: "_dot_")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
