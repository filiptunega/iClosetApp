import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                // Elegantný gradient pozadia
                LinearGradient(gradient: Gradient(colors: [Color("BackgroundTop"), Color("BackgroundBottom")]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()

                VStack(spacing: 36) {
                    Spacer()

                    // Logo alebo názov aplikácie
                    VStack(spacing: 10) {
                        Text("iCloset")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(Color("TextPrimary"))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                        Text("Welcome back!")
                            .font(.title2)
                            .foregroundColor(Color("TextSecondary"))
                    }

                    // Formuláre pre email a heslo
                    VStack(spacing: 24) {
                        InputView(text: $email,
                                  title: "Email",
                                  placeholder: "Enter your email")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)

                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  secureField: true)
                        .padding(.horizontal, 24)
                    }

                    // Tlačidlo pre prihlásenie
                    Button {
                        Task {
                            try await viewModel.logIn(withEmail: email, password: password)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Log In")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color("TextPrimary"))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal, 24)
                    .disabled(!formIsCorrect)
                    .opacity(formIsCorrect ? 1 : 0.5)

                    Spacer()

                    // Odkaz na registráciu
                    NavigationLink {
                        RegisterView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 6) {
                            Text("Don't have an account?")
                                .foregroundColor(Color("TextSecondary"))
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(Color("TextPrimary"))
                        }
                        .font(.footnote)
                    }

                    Spacer().frame(height: 20)
                }
            }
        }
    }
}

// MARK: - Form Validation
extension LoginView: AuthIsCorrect {
    var formIsCorrect: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return !email.isEmpty && !password.isEmpty && password.count >= 6 &&
        NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
