//
//  MockNetworkSession.swift
//  NetworkLayer
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation
@testable import NetworkLayer

actor MockNetworkSession: NetworkSessionActor {
    // MARK: - Properties to inject mock data & response
    let data: Data?
    let response: HTTPURLResponse?
    let error: Error?
    
    // MARK: - Life cycle
    public init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    // MARK: - Method
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        
        guard let data, let response else {
            throw NetworkError.invalidResponse
        }
        
        return (data, response)
    }
}
