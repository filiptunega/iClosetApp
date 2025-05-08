//
//  DailyInspirationWidgetView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//

import SwiftUI

struct DailyInspirationWidgetView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "lightbulb.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.orange)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Daily inspiration")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("TextPrimary"))

                    Text("Refresh your style")
                        .font(.caption2)
                        .foregroundColor(Color("TextSecundary"))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 70, alignment: .leading)
        .background(Color("WidgetPrimary"))
        .cornerRadius(12)
        .shadow(color: Color("Shadow").opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    DailyInspirationWidgetView()
}
