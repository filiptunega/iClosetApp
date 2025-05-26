import SwiftUI

struct ClothingCardView: View {
    let item: ClothingItem
    var isEditing: Bool

    var body: some View {
        NavigationLink(destination: ClothingDetailView(item: item)) {
            VStack(spacing: 8) {
                AsyncImage(url: URL(string: item.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .cornerRadius(10)
                        .padding(.top, 8)
                } placeholder: {
                    ProgressView()
                        .frame(height: 140)
                        .padding(.top, 8)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(Color("TextPrimary"))
                        .lineLimit(1)

                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(Color("TextSecondary"))
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .bottom], 8)
            }
            .background(Color("CardBackground"))
            .cornerRadius(12)
            .frame(height: 230)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
