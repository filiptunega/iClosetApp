//
//  ContentView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 05/05/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabView {
                    MyClosetView()
                        .tabItem{
                            Image(systemName: "tshirt")
                            Text("My Closet")
                        }
                    HomeView()
                        .tabItem{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    FavoritesView()
                        .tabItem{
                            Image(systemName: "star")
                            Text("Favourites")
                        }
                }
                .accentColor(Color("TextPrimary"))
            }
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}


