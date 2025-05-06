import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var showProfile = false
    
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
                            Text(user.initials)
                                .frame(width: 40, height: 40)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .background(Color("TextPrimary"))
                                .clipShape(Circle())
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
                    
                    // Tab bar
                    TabBar()
                }
                .padding(.top)
                .background(Color("Background").edgesIgnoringSafeArea(.all))
                .sheet(isPresented: $showProfile) {
                    ProfileView()
                }
            }
        }
    }
}



    struct TabBar: View {
        var body: some View {
            HStack {
                Spacer()
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "plus.circle")
                Spacer()
                Image(systemName: "heart")
                Spacer()
            }
            .padding()
            .background(Color("TabBarBackground"))
            .foregroundColor(.primary)
            
        }
    }
#Preview{
    HomeView()
}
