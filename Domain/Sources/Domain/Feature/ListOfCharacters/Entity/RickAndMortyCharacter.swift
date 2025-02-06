//
//  Character.swift
//  Domain
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct RickAndMortyCharacter: Sendable, Equatable, Hashable {
    public let id: Int
    public let characterImage: String
    public let characterName: String
    public let species: String
    public let status: CharacterStatus
    public let gender: CharacterGender
    
    public init(
        id: Int,
        characterImage: String,
        characterName: String,
        species: String,
        status: CharacterStatus,
        gender: CharacterGender
    ) {
        self.id = id
        self.characterImage = characterImage
        self.characterName = characterName
        self.species = species
        self.status = status
        self.gender = gender
    }
    
    // MARK: - Properties special for View
    public var characterImageURL: URL {
        URL(string: characterImage) ?? URL(string: "www.google.com")!
    }
    
    public var backgroundColor: String {
        switch status {
        case .alive: return "orange"
        case .dead: return "red"
        case .unknown: return "purple"
        }
    }
}
