//
//  ProfileView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 28/04/2025.
//


import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var userSettings: UserSettings
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text(userSettings.userName)
                                .font(.headline)
                            Text("Zobraziť profil")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("Nastavenia")) {
                    NavigationLink(destination: Text("Upraviť šatník")) {
                        Label("Upraviť šatník", systemImage: "square.and.pencil")
                    }
                    
                    NavigationLink(destination: Text("Notifikácie")) {
                        Label("Notifikácie", systemImage: "bell")
                    }
                }
                
                Section(header: Text("Podpora")) {
                    NavigationLink(destination: Text("O aplikácii")) {
                        Label("O aplikácii", systemImage: "info.circle")
                    }
                    
                    NavigationLink(destination: Text("Kontaktuj nás")) {
                        Label("Kontaktuj nás", systemImage: "envelope")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profil")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userSettings: UserSettings()) // Pridávame UserSettings pre preview
    }
}
