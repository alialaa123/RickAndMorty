//
//  File.swift
//  Domain
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public protocol ListOfCharactersRepository {
    func getListOfCharacters(with status: String?, page: Int) async throws -> [RickAndMortyCharacter]
}
