import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showLogOutAlert = false
    @State private var showDeleteAccountAlert = false
    @State private var profileImage: UIImage?

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color("TextPrimary"))]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color("TextPrimary"))]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                ZStack {
                    Color("Background").ignoresSafeArea()

                    List {
                        // MARK: - Profile Info
                        Section {
                            HStack(spacing: 16) {
                                Text(user.initials)
                                    .frame(width: 60, height: 60)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .background(Color("TextSecundary"))
                                    .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(user.username)
                                        .font(.headline)
                                        .foregroundColor(Color("TextPrimary"))
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(Color("TextSecundary"))
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color("CardBackground"))

                        // MARK: - Settings
                        Section(header: Text("Settings").foregroundColor(Color("TextSecundary"))) {
                            NavigationLink(destination: Text("Edit closet")) {
                                Label("Edit closet", systemImage: "square.and.pencil")
                                    .foregroundColor(Color("TextPrimary"))
                            }
                            .listRowBackground(Color("CardBackground"))

                            NavigationLink(destination: Text("Notifications")) {
                                Label("Notifications", systemImage: "bell")
                                    .foregroundColor(Color("TextPrimary"))
                            }
                            .listRowBackground(Color("CardBackground"))
                        }

                        // MARK: - Support
                        Section(header: Text("Support").foregroundColor(Color("TextSecundary"))) {
                            NavigationLink(destination: Text("About application")) {
                                Label("About application", systemImage: "info.circle")
                                    .foregroundColor(Color("TextPrimary"))
                            }
                            .listRowBackground(Color("CardBackground"))

                            NavigationLink(destination: Text("Contact us")) {
                                Label("Contact us", systemImage: "envelope")
                                    .foregroundColor(Color("TextPrimary"))
                            }
                            .listRowBackground(Color("CardBackground"))
                        }

                        // MARK: - Account
                        Section("Account") {
                            Button(role: .destructive) {
                                showLogOutAlert = true
                            } label: {
                                Label("Log out", systemImage: "arrow.left.circle")
                                    .foregroundColor(Color("TextSecundary"))
                            }
                            .listRowBackground(Color("CardBackground"))
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
                                    .foregroundColor(Color("TextSecundary"))
                            }
                            .listRowBackground(Color("CardBackground"))
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

// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
