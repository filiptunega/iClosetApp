import SwiftUI

struct ProfileView: View {

    var body: some View {
        NavigationStack {
            List {
                // Profilová hlavička
                Section {
                    HStack {
                        Text(User.MOCK_USER.initials)
                            .frame(width: 60, height: 60)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .background(Color(.systemBlue))
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(User.MOCK_USER.username)
                                .font(.headline)
                            Text(User.MOCK_USER.email)
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
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
