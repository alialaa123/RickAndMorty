//
//  RickAndMortyCharacterDTO.swift
//  Data
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation
import Domain

public struct RickAndMortyCharacterDTO: Decodable, Sendable {
    // MARK: - Properties
    public let id: Int
    public let characterImage: String?
    public let characterName: String?
    public let species: String?
    public let status: CharacterStatusDTO?
    public let gender: CharacterGenderDTO?
    
    // MARK: - Coding key
    public enum CodingKeys: String, CodingKey {
        case id, species, status, gender
        case characterImage = "image"
        case characterName = "name"
    }
    
    // MARK: - Method
    public func toDomain() -> RickAndMortyCharacter {
        RickAndMortyCharacter(
            id: id,
            characterImage: characterImage ?? "",
            characterName: characterName ?? "",
            species: species ?? "",
            status: status?.toDomain() ?? .unknown,
            gender: gender?.toDomain() ?? .unknown
        )
    }
}
