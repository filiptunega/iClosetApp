//
//  WeatherWidgetView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 06/05/2025.
//

import SwiftUI

struct WeatherWidgetView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            
            Text("21° Sunny")
                .font(.title3)
                .bold()
            Text("Today")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
    }
}

