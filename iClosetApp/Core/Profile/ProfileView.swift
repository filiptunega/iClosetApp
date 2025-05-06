import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showLogOutAlert = false
    @State private var showDeleteAccountAlert = false
    @State private var profileImage: UIImage?

    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                ZStack {
                    Color("Background")
                        .ignoresSafeArea()

                    List {
                        // MARK: - Profile Info
                        Section {
                            HStack(spacing: 16) {
                                Text(user.initials)
                                    .frame(width: 60, height: 60)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .background(Color("TextPrimary"))
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

                        // MARK: - Settings
                        Section(header: Text("Settings")) {
                            NavigationLink(destination: Text("Edit closet")) {
                                Label("Edit closet", systemImage: "square.and.pencil")
                            }
                            .listRowBackground(Color.white.opacity(0.8))
                            .foregroundColor(Color("TextPrimary"))

                            NavigationLink(destination: Text("Notifications")) {
                                Label("Notifications", systemImage: "bell")
                            }
                            .listRowBackground(Color.white.opacity(0.8))
                            .foregroundColor(Color("TextPrimary"))
                        }

                        // MARK: - Support
                        Section(header: Text("Support")) {
                            NavigationLink(destination: Text("About application")) {
                                Label("About application", systemImage: "info.circle")
                            }
                            .listRowBackground(Color.white.opacity(0.8))
                            .foregroundColor(Color("TextPrimary"))

                            NavigationLink(destination: Text("Contact us")) {
                                Label("Contact us", systemImage: "envelope")
                            }
                            .listRowBackground(Color.white.opacity(0.8))
                            .foregroundColor(Color("TextPrimary"))
                        }

                        // MARK: - Account
                        Section("Account") {
                            Button(role: .destructive) {
                                showLogOutAlert = true
                            } label: {
                                Label("Log out", systemImage: "arrow.left.circle")
                            }
                            .listRowBackground(Color.white.opacity(0.8))
                            .foregroundColor(.gray)
                            .confirmationDialog("Are you sure you want to log out?", isPresented: $showLogOutAlert, titleVisibility: .visible) {
                                Button(role: .destructive) {
                                    viewModel.signOut()
                                } label: {
                                    Label("Log out", systemImage: "arrow.left.circle")
                                }
                            }

                            Button(role: .destructive) {
                                showDeleteAccountAlert = true
                            } label: {
                                Label("Delete account", systemImage: "xmark.circle")
                            }
                            .listRowBackground(Color.white.opacity(0.8))
                            .foregroundColor(.gray)
                            .confirmationDialog("Are you sure you want to delete your account?", isPresented: $showDeleteAccountAlert, titleVisibility: .visible) {
                                Button(role: .destructive) {
                                    viewModel.signOut()
                                } label: {
                                    Label("Delete account", systemImage: "xmark.circle")
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                }
                .navigationTitle("Profile")
            }
        } else {
            Text("Loading...")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel()) // Pridaj kvôli náhľadu
    }
}
