//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by ali alaa on 04/02/2025.
//

import Foundation

// MARK: - Error Handling
public enum NetworkError: Error, Sendable, LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int, error: Sendable?)
    case decodingError(Error)
    case requestFailed(Error)
    
    // MARK: - Property
    /// Error description
    public var errorDescription: String? {
        switch self {
        case .invalidURL: 
            return "Invalid URL 🧐"
        case .invalidResponse:
            return "Invalid Response 🫠"
        case .serverError(statusCode: let code, error: _):
            return "We are sorry, something occurs on server 🙄 \(code)"
        case .decodingError(let error):
            return "Decoding Error 🙀, Error: \(error.localizedDescription)"
        case .requestFailed(let error):
            return "Failed in making request 👾, Error: \(error.localizedDescription)"
        }
    }
}
