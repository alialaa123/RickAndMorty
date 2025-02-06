//
//  ListOfCharactersUseCase.swift
//  Domain
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public protocol ListOfCharactersUseCase {
    func execute(with status: String?, page: Int) async throws -> [RickAndMortyCharacter]
}

public final class DefaultListOfCharactersUseCase: ListOfCharactersUseCase {
    // MARK: - Properties
    private let repository: ListOfCharactersRepository
    
    // MARK: - Life cycle
    public init(repository: ListOfCharactersRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    public func execute(with status: String?, page: Int) async throws -> [RickAndMortyCharacter] {
        try await repository.getListOfCharacters(with: status, page: page)
    }
}
