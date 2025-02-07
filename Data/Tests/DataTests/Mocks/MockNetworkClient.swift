//
//  File.swift
//  Data
//
//  Created by ali alaa on 07/02/2025.
//

import Foundation
import NetworkLayer
import Domain
@testable import Data

final class MockNetworkClient: NetworkClient, @unchecked Sendable {
    // MARK: - Properties
    private var sendResult: Result<ListOfCharactersResponseDTO, Error> = .success(ListOfCharactersResponseDTO(results: []))
        
    // MARK: - Method
    func setSendRequest(_ result: Result<ListOfCharactersResponseDTO, Error>) {
        self.sendResult = result
    }
    
    func send<Request: NetworkRequest>(_ request: Request) async throws -> Request.Response {
        switch sendResult {
        case .success(let response):
            return response as! Request.Response
        case .failure(let error):
            throw error
        }
    }
}
