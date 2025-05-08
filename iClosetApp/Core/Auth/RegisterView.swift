import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("BackgroundTop"), Color("BackgroundBottom")]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()

                VStack(spacing: 32) {
                    Spacer()

                    VStack(spacing: 8) {
                        Text("Create Account")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color("TextPrimary"))
                        Text("Join iCloset and get started")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    // Inputs
                    VStack(spacing: 20) {
                        InputView(text: $username,
                                  title: "Username",
                                  placeholder: "Enter your username")

                        InputView(text: $email,
                                  title: "Email",
                                  placeholder: "Enter your email")
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  secureField: true)

                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Re-enter your password",
                                  secureField: true)
                    }
                    .padding(.horizontal)

                    // Sign Up Button
                    Button {
                        Task {
                            try await viewModel.CreateUser(withEmail: email, password: password, username: username)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color("TextPrimary"))
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                    .padding(.horizontal)
                    .disabled(!formIsCorrect)
                    .opacity(formIsCorrect ? 1 : 0.5)

                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .foregroundColor(Color("TextSecondary"))
                            Text("Log In")
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

// MARK: - Validation
extension RegisterView: AuthIsCorrect {
    var formIsCorrect: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return !email.isEmpty &&
               !password.isEmpty &&
               password.count >= 6 &&
               NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email) &&
               password == confirmPassword &&
               !username.isEmpty &&
               username.count >= 3
    }
}

// MARK: - Preview
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(AuthViewModel())
    }
}
