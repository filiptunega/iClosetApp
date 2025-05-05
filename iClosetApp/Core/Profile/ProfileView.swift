import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                List {
                    // Profilová hlavička
                    Section {
                        HStack {
                            Text(user.initials)
                                .frame(width: 60, height: 60)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .background(Color(.systemBlue))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .font(.headline)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // Nastavenia
                    Section(header: Text("Settings")) {
                        NavigationLink(destination: Text("Edit closet")) {
                            Label("Edit closet", systemImage: "square.and.pencil")
                        }
                        
                        NavigationLink(destination: Text("Notifications")) {
                            Label("Notifications", systemImage: "bell")
                        }
                    }
                    
                    // Podpora
                    Section(header: Text("Support")) {
                        NavigationLink(destination: Text("About application")) {
                            Label("About application", systemImage: "info.circle")
                        }
                        
                        NavigationLink(destination: Text("Contact us")) {
                            Label("Contact us", systemImage: "envelope")
                        }
                    }
                    
                    // Odhlásenie (bez funkcie)
                    Section("Account"){
                        Button(role: .destructive) {
                            viewModel.signOut()
                        } label: {
                            Label("Log out", systemImage: "arrow.left.circle")
                                .foregroundColor(.red)
                        }
                        Button(role: .destructive) {
                            
                        } label: {
                            Label("Delete account", systemImage: "xmark.circle")
                                .foregroundColor(.red)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Profile")
            }}
            else {
                Text("Loading...")
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
