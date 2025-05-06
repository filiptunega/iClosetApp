import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
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

                    // App Logo or Title
                    VStack(spacing: 8) {
                        Text("iCloset")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color("TextPrimary"))
                        Text("Welcome back!")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }

                    // Inputs
                    VStack(spacing: 20) {
                        InputView(text: $email,
                                  title: "Email",
                                  placeholder: "Enter your email")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  secureField: true)
                    }
                    .padding(.horizontal)

                    // Login Button
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
                        .shadow(radius: 3)
                    }
                    .padding(.horizontal)
                    .disabled(!formIsCorrect)
                    .opacity(formIsCorrect ? 1 : 0.5)

                    Spacer()

                    // Sign Up Navigation
                    NavigationLink {
                        RegisterView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
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
