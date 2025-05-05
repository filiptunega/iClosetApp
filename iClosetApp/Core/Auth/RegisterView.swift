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
                        InputView(text: $confirmPassword, title: "Confirm password", placeholder: "Confirm your password")
                        
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
    
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView()
        }
    }
