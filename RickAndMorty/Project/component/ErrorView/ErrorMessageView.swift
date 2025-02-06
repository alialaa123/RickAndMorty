//
//  ErrorMessageView.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI

struct ErrorMessageView: View {
    let errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Error: \(errorMessage ?? "")")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.white)
                .padding(8)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.red.opacity(0.8))
        .cornerRadius(12)
    }
}

#Preview {
    ErrorMessageView(errorMessage: "Something happen now 🙉")
}
