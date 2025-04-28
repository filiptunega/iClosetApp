import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "Všetko"
    @State private var clothes = [
        "Biele tričko",
        "Modré rifle",
        "Kožená bunda",
        "Tenisky"
    ]
    @StateObject var userSettings = UserSettings()

    let categories = ["Všetko", "Tričká", "Nohavice", "Bundy", "Topánky"]

    var body: some View {
        TabView {
            // Home View
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray4)]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()

                    VStack(alignment: .leading, spacing: 16) {
                        Text("iCloset")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 10)
                            .padding(.leading, 8)
                        
                        HStack {
                            TextField("Hľadať", text: $searchText)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                            
                            Button(action: {
                                // akcia na zoradenie
                            }) {
                                Image(systemName: "slider.horizontal.3")
                                    .font(.title2)
                                    .padding(10)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(12)
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                    }) {
                                        Text(category)
                                            .font(.subheadline)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(selectedCategory == category ? Color.blue : Color.clear, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                            .padding(.leading, 2)
                        }
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                ForEach(clothes.filter { searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }, id: \.self) { item in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color(.systemGray5))
                                            .frame(height: 120)
                                        
                                        Text(item)
                                            .font(.footnote)
                                            .foregroundColor(.primary)
                                            .padding(.top, 4)
                                    }
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(16)
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                // pridať nový kus oblečenia
                            }) {
                                Image(systemName: "plus")
                                    .font(.title)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding()
                        }
                    }
                }
            }
            .tabItem {
                Label("Domov", systemImage: "house.fill")
            }
            
            // Profil View (Pridáme ProfileView sem a predáme userSettings)
            ProfileView(userSettings: userSettings)
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
            
            // Nastavenia View
            Text("Nastavenia Content")
                .tabItem {
                    Label("Nastavenia", systemImage: "gearshape.fill")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
