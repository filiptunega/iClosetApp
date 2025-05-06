//
//  DailyInspirationWidgetView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//

import SwiftUI

struct DailyInspirationWidgetView: View {
    var body: some View {
        VStack {
            Text("Daily inspiration")
                .font(.title3)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
    }
}

#Preview {
    DailyInspirationWidgetView()
}
