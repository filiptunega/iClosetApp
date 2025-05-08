import SwiftUI

struct ClothingDetailView: View {
    let item: ClothingItem

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(16)
                        .padding(.horizontal)

                    Text(item.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextPrimary"))

                    Text(item.description)
                        .font(.body)
                        .foregroundColor(Color("TextSecondary"))

                    // MARK: - List with item parameters
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Details")
                            .font(.headline)
                            .foregroundColor(Color("TextPrimary"))

                        detailRow(label: "Material", value: "Cotton")
                        detailRow(label: "Size", value: "M")
                        detailRow(label: "Brand", value: "Zara")
                        detailRow(label: "Color", value: "White")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("CardBackground"))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.top)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helper for row layout
    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(Color("TextSecondary"))
            Spacer()
            Text(value)
                .foregroundColor(Color("TextPrimary"))
                .fontWeight(.medium)
        }
        .font(.subheadline)
    }
}
