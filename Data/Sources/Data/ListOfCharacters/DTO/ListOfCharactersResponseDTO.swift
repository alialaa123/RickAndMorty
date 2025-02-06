//
//  ListOfCharactersResponseDTO.swift
//  Data
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation

public struct ListOfCharactersResponseDTO: Decodable, Sendable {
    public let results: [RickAndMortyCharacterDTO]
}
