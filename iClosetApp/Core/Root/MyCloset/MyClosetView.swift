import SwiftUI

struct MyClosetView: View {
    @State private var searchText = ""
    @State private var isEditing = false

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
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color("Background").ignoresSafeArea()

                VStack(spacing: 0) {
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

                AddButton()
            }
            .navigationTitle("My Closet")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        isEditing.toggle()
                    }
                    .font(.subheadline)
                    .foregroundColor(Color("TextPrimary"))
                }
            }
        }
    }
}
