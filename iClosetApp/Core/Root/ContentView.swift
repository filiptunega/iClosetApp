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
                HomeView()
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
