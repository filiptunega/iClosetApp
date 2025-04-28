import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false
    
    @EnvironmentObject var userSettings: UserSettings // Prístup k globálnym údajom
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray4)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    // "Log In" Text na vrchu
                    Text("Log In")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)
                    
                    // Formulár s poliami
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        SecureField("Password", text: $password)
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
                    
                    // Tlačidlo pre prihlásenie (zväčšené)
                    Button(action: {
                        loginUser()
                    }) {
                            Text("Log in")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                                .padding(.horizontal)
                        
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Preklik na Register stránku
                    NavigationLink("Don't have an account? Sign Up", destination: RegisterView())
                        .padding(.bottom, 20)
                        .foregroundColor(.blue)
                }
                .padding()
                
                // Presmerovanie na HomeView po úspešnom prihlásení
                if userSettings.isLoggedIn {
                    HomeView() // Týmto sa zobrazí HomeView po úspešnom prihlásení
                        .transition(.move(edge: .trailing))
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func loginUser() {
        isLoading = true
        errorMessage = ""
        
        // Prihlásenie používateľa v Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            isLoading = false
            
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
                return
            }
            
            // Prihlásenie bolo úspešné
            print("User logged in successfully: \(authResult?.user.email ?? "")")
            
            // Uloženie údajov do globálnych premenných
            userSettings.email = authResult?.user.email ?? ""
            userSettings.userName = "User" // Môžete to nahradiť reálnym užívateľským menom
            userSettings.isLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserSettings()) // Pridajte environment object
    }
}
