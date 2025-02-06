//
//  Character.swift
//  Domain
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct RickAndMortyCharacter: Sendable {
    public let id: Int
    public let characterImageURL: String
    public let characterName: String
    public let species: String
    public let status: CharacterStatus
    public let gender: CharacterGender
    
    public init(
        id: Int,
        characterImageURL: String,
        characterName: String,
        species: String,
        status: CharacterStatus,
        gender: CharacterGender
    ) {
        self.id = id
        self.characterImageURL = characterImageURL
        self.characterName = characterName
        self.species = species
        self.status = status
        self.gender = gender
    }
}
