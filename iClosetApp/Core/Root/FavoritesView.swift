import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var showProfile = false

    
    var body: some View {
        
        if let user = viewModel.currentUser{
            
            NavigationStack {
                VStack {
                    HStack {
                        Text("Favorites")
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
                        
                        ZStack(alignment: .bottomTrailing) {
                            Color("Background").ignoresSafeArea()
                            
                            VStack(spacing: 24) {
                                Spacer()
                                
                                Image(systemName: "heart.slash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.gray.opacity(0.5))
                                
                                Text("No favorites yet")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("TextPrimary"))
                                
                                Text("Add items to your favorites to see them here.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 32)
                                
                                Spacer()
                            }
                            .padding()
                        }
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
