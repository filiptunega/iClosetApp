import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray4)]), startPoint: .top, endPoint: .bottom)
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
                        print("User log in..")
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
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
