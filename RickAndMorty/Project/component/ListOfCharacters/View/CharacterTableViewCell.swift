//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI
import Domain

struct CharacterTableViewCell: View {
    let character: RickAndMortyCharacter
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CharacterPosterView(
                characterPoster: character.characterImageURL,
                posterWidth: 100,
                posterHeight: 100
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.characterName)
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                
                Text(character.species)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
            }
            
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        )
        .background(ConvertStringToColor(color: character.backgroundColor).colorValue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 12)
    }
}

#Preview {
    CharacterTableViewCell(
        character: RickAndMortyCharacter(
            id: 1,
            characterImage: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            characterName: "Rick Sanchez",
            species: "Human",
            status: .alive,
            gender: .male
        )
    )
}
