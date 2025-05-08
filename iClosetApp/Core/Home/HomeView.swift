import SwiftUI

// MARK: - HomeView
struct HomeView: View {
    @State var showProfile = false
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
                        header(user: user)
                        widgetsSection
                        mainOutfitSection
                        suggestedOutfitsSection
                    }
                    .padding()
                }
                .background(Color("Background").ignoresSafeArea())
                .sheet(isPresented: $showProfile) {
                    ProfileView()
                }
                .navigationBarHidden(true)
            }
        } else {
            ProgressView("Loading data...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Background").ignoresSafeArea())
        }
    }

    // MARK: - Header
    private func header(user: User) -> some View {
        HStack {
            Text("iCloset")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("TextPrimary"))

            Spacer()

            Button {
                showProfile.toggle()
            } label: {
                if !user.hasProfilePicture {
                    Text(user.initials)
                        .frame(width: 40, height: 40)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .background(Color("Labels"))
                        .clipShape(Circle())
                } else {
                    Text("PP")
                        .frame(width: 40, height: 40)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .background(Color("TextPrimary"))
                        .clipShape(Circle())
                }
            }
        }
    }

    // MARK: - Widgets Section
    private var widgetsSection: some View {
        HStack(spacing: 16) {
            WeatherWidgetView()
            DailyInspirationWidgetView()
        }
    }

    // MARK: - Main Outfit
    private var mainOutfitSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("AI-generated outfit")
                .font(.headline)
                .foregroundColor(.gray)

            Image("main_outfit")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipped()
                .cornerRadius(12)
        }
    }

    // MARK: - Suggested Outfits
    private var suggestedOutfitsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Suggested outfits")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(1..<6) { i in
                        Image("outfit_\(i)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 160)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView().environmentObject(AuthViewModel())
}
