//
//  NetworkRequest.swift
//  NetworkLayer
//
//  Created by ali alaa on 04/02/2025.
//

import Foundation

// MARK: - Request Layer
public protocol NetworkRequest: Sendable {
    associatedtype Response: Decodable & Sendable
    associatedtype ErrorType: Error & Sendable
    associatedtype QueryParameters: Encodable & Sendable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: QueryParameters? { get }
    var body: Data? { get }
    
    /// Custom headers
    var customHeaders: [String: String]? { get }
    
    /// For custom validator
    var validator: ResponseValidator { get }
}

// MARK: - Default Validator
public extension NetworkRequest {
    var validator: ResponseValidator {
        DefaultResponseValidator.default
    }
    
    var customHeaders: [String: String]? { nil }
    var queryParameters: QueryParameters? { nil }
    var body: Data? { nil }
}
