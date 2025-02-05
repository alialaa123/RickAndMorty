//
//  AppNetworkConfiguration.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct AppNetworkConfiguration: NetworkConfiguration {
    // MARK: - Properties
    public let baseURL: URL
    public let defaultHeaders: [String: String]
    
    // MARK: - Life cycle
    public init(baseURL: URL, defaultHeaders: [String: String] = [:]) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
    }
}
