//
//  File.swift
//  NetworkLayer
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation

struct MockCharactersResponse: Decodable, Sendable {
    let results: [MockRickAndMortyCharacter]?
}
