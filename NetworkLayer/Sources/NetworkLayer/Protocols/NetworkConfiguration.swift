//
//  NetworkConfiguration.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public protocol NetworkConfiguration: Sendable {
    var baseURL: URL { get }
    var defaultHeaders: [String: String] { get }
}
