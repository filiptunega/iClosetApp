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
                LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray4)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Sign up")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)
                    VStack(spacing: 16,){
                        InputView(text: $username, title: "Username", placeholder: "Username")
                        
                        InputView(text: $email,
                                  title: "Email",
                                  placeholder: "Email")
                        .autocapitalization(.none)
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Password",
                                  secureField: true)
                        
                        InputView(text: $confirmPassword, title: "Confirm password", placeholder: "Confirm your password",
                                  secureField: true)
                        
                    }
                    
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    Button{
                        Task {
                            try await viewModel.CreateUser(withEmail: email, password: password, username: username )
                        }
                    } label: {
                        HStack{
                            Text("Sign up")
                            Image(systemName: "arrow.right")
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-32, height: 48)
                        
                        
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(12)
                    .padding(.top, 24,)
                    .padding(.horizontal)
                    .disabled(!formIsCorrect)
                    .opacity(formIsCorrect ? 1 : 0.5)
                    
                    
                    Spacer()
                    
                    Button{
                        dismiss()
                    }
                    label:{
                        
                        HStack(spacing: 2){
                            Text("Already have an account? ")
                            Text("Log in")
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                    }
                    .padding()
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}
extension RegisterView: AuthIsCorrect {
    var formIsCorrect: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return !email.isEmpty
        && !password.isEmpty
        && password.count >= 6
        && NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
        && password == confirmPassword
        && !username.isEmpty
        && username.count >= 3
        
    }
    
    
}
    
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView()
        }
    }
