//
//  MockRickAndMortyCharacter.swift
//  NetworkLayer
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation

struct MockRickAndMortyCharacter: Decodable, Encodable, Sendable {
    let id: Int
    let name: String
    let image: String
    let species: String
    let gender: String
}
