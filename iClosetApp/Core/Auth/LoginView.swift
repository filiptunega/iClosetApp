import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(.systemGray3), Color(.systemGray4)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Log In")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)
                    
                    VStack(spacing: 16,){
                        InputView(text: $email,
                                  title: "Email",
                                  placeholder: "Email")
                        .autocapitalization(.none)
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Password",
                                  secureField: true)
                        
                    }
                    
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    Button{
                        Task{
                            try await viewModel.logIn(withEmail: email, password: password)
                        }
                    } label: {
                        HStack{
                            Text("Log in")
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
                    
                    
                    NavigationLink{
                        RegisterView()
                            .navigationBarBackButtonHidden(true)
                    }
                    label:{
                        
                        HStack(spacing: 2){
                            Text("Don't have an account? ")
                            Text("Sign Up")
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
    
extension LoginView: AuthIsCorrect {
    var formIsCorrect: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return !email.isEmpty && email.contains("@")
        && !password.isEmpty
        && password.count >= 6
         && NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
        
    }
    
    
}

    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
