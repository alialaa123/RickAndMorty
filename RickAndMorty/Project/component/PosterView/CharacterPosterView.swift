//
//  CharacterPosterView.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI

struct CharacterPosterView: View {
    // MARK: - Properties
    var characterPoster: URL?
    /// frame
    var posterWidth: CGFloat = 100
    var posterHeight: CGFloat = 100
    var cornerRadius: CGFloat = 16
    
    // MARK: - View
    var body: some View {
        AsyncImage(url: characterPoster) { phase in
            switch phase {
            case .empty:
                ProgressView()
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: posterWidth, height: posterHeight)
        .foregroundColor(.gray)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

#Preview {
    CharacterPosterView(
        characterPoster: URL(
            "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        )
    )
}
