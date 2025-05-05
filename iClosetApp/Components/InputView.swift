//
//  InputView.swift
//  iClosetApp
//
//  Created by Filip Tunega on 05/05/2025.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var secureField = false
    
    
    var body: some View {
            if secureField {
                SecureField(title, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .font(.system(size: 14))
                    
            }
            else
            {
                TextField(title, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .font(.system(size: 14))
                    
            }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeholder: "e-mail")
}
