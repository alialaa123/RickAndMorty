//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by ali alaa on 04/02/2025.
//

import Foundation

// MARK: - Error Handling
public enum NetworkError: Error, Sendable {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int, error: Sendable?)
    case decodingError(Error)
    case requestFailed(Error)
}
