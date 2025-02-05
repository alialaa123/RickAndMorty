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
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: QueryParameters? { get }
    var body: Data? { get }
    
    /// For custom validator
    var validator: ResponseValidator { get }
    
    /// Giving URLRequest func for override the default implementation, for specific cases
    func urlRequest() throws -> URLRequest
}

// MARK: - Default Validator
public extension NetworkRequest {
    var validator: ResponseValidator {
        DefaultResponseValidator.default
    }
}

// MARK: - Make URLRequest
public extension NetworkRequest {
    /// Making URLRequest a throwing function to handle errors
    /// Invalid URLs || Query parameters
    func urlRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        /// Encode QueryParameters
        if let queryParameters = queryParameters {
            let encoder = URLQueryItemEncoder()
            components.queryItems = try encoder.encode(queryParameters)
        }
        
        /// Validate the URL
        guard let requestURL = components.url else {
            throw NetworkError.invalidURL
        }
        
        /// Create the URLRequest
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 10 // We can enhance, by extract it to be input for networkRequest
        request.httpBody = body
        
        return request
    }
}
