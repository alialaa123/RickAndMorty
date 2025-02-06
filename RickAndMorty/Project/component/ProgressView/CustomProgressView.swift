//
//  CustomProgressView.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI

struct CustomProgressView: View {
    
    var body: some View {
        ProgressView {
            Text("Fetching...")
                .font(Font.custom("AvenirNext-Medium", size: 14))
        }
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    CustomProgressView()
}
