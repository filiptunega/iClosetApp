import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var selectedTab = 2
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ZStack {
                    TabView(selection: $selectedTab) {
                        MyClosetView()
                            .tabItem {
                                Image(systemName: "tshirt")
                                Text("My Closet")
                            }
                            .tag(0)

                        
                        HomeView()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                            .tag(2)
                        
                        FavoritesView()
                            .tabItem {
                                Image(systemName: "star")
                                Text("Favourites")
                            }
                            .tag(3)

                    }
                    .accentColor(Color("TextPrimary"))
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
