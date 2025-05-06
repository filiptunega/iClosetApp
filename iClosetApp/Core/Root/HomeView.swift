import SwiftUI

struct HomeView: View {
    @State var showProfile = false
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser {
            
            
            
            NavigationView {
                VStack(spacing: 16) {
                    
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
                                    .background(Color("TextPrimary"))
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
                    .padding(.horizontal)
                    
                    // Widgets
                    HStack(spacing: 16) {
                        WeatherWidgetView()
                        DailyInspirationWidgetView()
                    }
                    .padding(.horizontal)
                    
                    // Main outfit
                    VStack {
                        Text("AI-generated")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 4)
                        
                        Image("main_outfit")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // Suggested outfits
                    VStack(alignment: .leading) {
                        Text("Suggested outfits")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(1..<6) { i in
                                    Image("outfit_\(i)")
                                        .resizable()
                                        .frame(width: 120, height: 160)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()

                }
                .padding(.top)
                .background(Color("Background").edgesIgnoringSafeArea(.all))
                .sheet(isPresented: $showProfile) {
                    ProfileView()
                }
            }
        }
        else {
            Text("Loading data...")
        }
    }
}

    struct TabBar: View {
        var body: some View {
            HStack {
                Image(systemName: "tshirt.fill")
                Spacer()
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "heart")
            }
            .padding()
            .background(Color("TabBarBackground"))
            .foregroundColor(.primary)
            
        }
    }
#Preview{
    HomeView()
}
