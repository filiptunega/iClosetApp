import SwiftUI

struct MyClosetView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var showProfile = false
    @State private var showAddClothing: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    @StateObject private var closetVM = ClosetViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var filteredClothes: [ClothingItem] {
        if searchText.isEmpty {
            return closetVM.clothes
        } else {
            return closetVM.clothes.filter {
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
                        .padding(.horizontal)
                        SearchBar(text: $searchText)
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 2) {
                                ForEach(filteredClothes) { item in
                                    ClothingCardView(item: item, isEditing: isEditing)
                                        .frame(maxHeight: 250)
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
                .onAppear {
                    if closetVM.clothes.isEmpty {
                        closetVM.fetchClothes(for: user.id)
                    }
                }
            }
        } else {
            Text("Not logged in")
                .foregroundColor(.gray)
        }
    }
}
