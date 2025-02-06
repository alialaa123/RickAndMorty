//
//  MockGetCharacterRequest.swift
//  NetworkLayer
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation
@testable import NetworkLayer

struct MockGetCharacterRequest: NetworkRequest {
    typealias Response = MockCharactersResponse
    typealias ErrorType = NetworkError
    
    var path: String { "/characters" }
    var method: HTTPMethod { .get }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    var queryParameters: [String: String]? { nil }
    var body: Data? { nil }
    var validator: ResponseValidator {
        DefaultResponseValidator()
    }
}
