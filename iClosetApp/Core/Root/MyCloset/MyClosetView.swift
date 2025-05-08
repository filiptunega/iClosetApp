import SwiftUI

struct MyClosetView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var showProfile = false
    @State private var showAddClothing: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    let clothes: [ClothingItem] = [
        ClothingItem(name: "White Shirt", description: "Cotton, slim fit", imageName: "shirt.white"),
        ClothingItem(name: "Beige Pants", description: "Casual chinos", imageName: "pants.beige"),
        ClothingItem(name: "Navy Blazer", description: "Formal jacket", imageName: "blazer.navy"),
        ClothingItem(name: "Sneakers", description: "White leather", imageName: "shoes.sneakers")
    ]
    
    var filteredClothes: [ClothingItem] {
        if searchText.isEmpty {
            return clothes
        } else {
            return clothes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        if let user = viewModel.currentUser {
            
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    Color("Background").ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("My closet")
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
                        SearchBar(text: $searchText)
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredClothes) { item in
                                    ClothingCardView(item: item, isEditing: isEditing)
                                }
                            }
                            .padding()
                        }
                    }
                    .padding(.top)
                    .sheet(isPresented: $showProfile) {
                        ProfileView()
                    }
                    .sheet(isPresented: $showAddClothing) {
                        AddClothingView()
                    }
                    
                    AddButton(showAddClothing: $showAddClothing)
                }
                
                    
                
            }
        }
    }
}
