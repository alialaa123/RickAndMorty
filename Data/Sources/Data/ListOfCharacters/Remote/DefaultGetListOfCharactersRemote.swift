//
//  File.swift
//  Data
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation
import NetworkLayer
import Domain

public final class DefaultGetListOfCharactersRemote: ListOfCharactersRepository {
    // MARK: - Properties
    private let networkClient: NetworkClient
    
    // MARK: - Life cycle
    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - Methods
    public func getListOfCharacters(for page: Int) async throws -> [RickAndMortyCharacter] {
        let request = FetchListOfCharactersRequest(page: page, limit: 20)
        let requestResponse = try await networkClient.send(request)
        
        let listOfCharacters = requestResponse.results.map { $0.toDomain() }
        
        return listOfCharacters
    }
}
