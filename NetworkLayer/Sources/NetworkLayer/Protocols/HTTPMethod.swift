//
//  HTTPMethod.swift
//  NetworkLayer
//
//  Created by ali alaa on 04/02/2025.
//

import Foundation

// MARK: - Supporting Types
public enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
