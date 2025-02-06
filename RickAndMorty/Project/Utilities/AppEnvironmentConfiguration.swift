//
//  AppEnvironmentConfiguration.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation
import NetworkLayer

enum AppEnvironmentConfiguration {
    // MARK: - App Environment Cases
    case development
    
    // MARK: - Configurations
    var configuration: NetworkConfiguration {
        switch self {
        case .development:
            return AppNetworkConfiguration(
                baseURL: URL(string: "https://rickandmortyapi.com/api")!,
                defaultHeaders: [:]
            )
        }
    }
    
    var requestInterceptor: [RequestInterceptor] {
        switch self {
        case .development:
            return [
                RetryInterceptor(maxRetryCount: 2),
                LoggingInterceptor()
            ]
        }
    }
    
    var responseInterceptor: [ResponseInterceptor] {
        switch self {
        case .development:
            return [
                LoggingInterceptor()
            ]
        }
    }
    
    var caching: Caching {
        switch self {
        case .development:
            return InMemoryCache()
        }
    }
}
