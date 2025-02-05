//
//  APIError.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

struct APIError: Decodable, Error, Sendable {
    let code: Int
    let message: String
}
