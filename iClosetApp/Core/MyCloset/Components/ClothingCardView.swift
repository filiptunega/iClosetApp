import SwiftUI

struct ClothingCardView: View {
    let item: ClothingItem
    var isEditing: Bool

    var body: some View {
        NavigationLink(destination: ClothingDetailView(item: item)) {
            VStack(spacing: 8) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 140) // väčší obrázok
                    .cornerRadius(10)
                    .padding(.top, 8)

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
        .buttonStyle(PlainButtonStyle()) // odstráni highlight efekt odkazu
    }
}
