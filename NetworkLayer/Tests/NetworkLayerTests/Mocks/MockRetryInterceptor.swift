//
//  MockRetryInterceptor.swift
//  NetworkLayer
//
//  Created by ali alaa on 07/02/2025.
//

import Foundation
@testable import NetworkLayer

final class MockRetryInterceptor: RequestInterceptor, @unchecked Sendable {
    // MARK: - Properties
    var response: [Result<URLRequest, Error>] = []
    private(set) var count = 0
    
    // MARK: - Method
    func adapt(_ request: URLRequest) async throws -> URLRequest {
        count += 1
        
        guard !response.isEmpty else {
            throw NetworkError.requestFailed(NSError())
        }
        
        let response = response.removeFirst()
        switch response {
        case .success(let urlRequest):
            return urlRequest
        case .failure(let error):
            throw error
        }
    }
}
