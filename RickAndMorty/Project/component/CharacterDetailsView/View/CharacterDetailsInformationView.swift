//
//  CharacterDetailsInformationView.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI
import Domain

struct CharacterDetailsInformationView: View {
    // MARK: - Properties
    let character: RickAndMortyCharacter
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .top) {
            
            rightComponentInformation
            
            Spacer()
            
            leftComponentInformation
        }
        .padding()
        .background(.black.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 21))
        .padding()
    }
    
    // MARK: - Make Information text
    func makeInformationText(
        with fontSize: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .rounded,
        textColor: Color = .white,
        title: String
    ) -> some View {
        Text(title.capitalized)
            .font(.system(size: fontSize, weight: weight, design: design))
            .foregroundStyle(textColor)
    }
    
    // MARK: - Right component Information
    var rightComponentInformation: some View {
        VStack(alignment: .leading, spacing: 12) {
            makeInformationText(
                with: 31,
                weight: .bold,
                title: character.characterName
            )
            
            HStack(alignment: .center) {
                makeInformationText(
                    with: 21,
                    title: character.species
                )
                
                makeInformationText(
                    with: 16,
                    title: "・"
                )
                
                makeInformationText(
                    with: 21,
                    textColor: .gray,
                    title: character.gender.rawValue
                )
            }
        }
    }
    
    var leftComponentInformation: some View {
        Text(character.status.rawValue.capitalized)
            .font(.system(size: 18, weight: .regular, design: .rounded))
            .foregroundStyle(.white)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(
                ConvertStringToColor(
                    color: character.backgroundColor
                ).colorValue
            )
            .clipShape(RoundedRectangle(cornerRadius: 21))
    }
}

// MARK: - Preview
#Preview {
    CharacterDetailsInformationView(
        character: RickAndMortyCharacter(
            id: 1,
            characterImage: "MortySmith.jpg",
            characterName: "Morty Smith",
            species: "human",
            status: .alive,
            gender: .male
        )
    )
}
