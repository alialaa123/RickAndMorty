//
//  DefaultRequestInterceptor.swift
//  NetworkLayer
//
//  Created by ali alaa on 07/02/2025.
//

import Foundation

public struct DefaultRequestInterceptor: RequestInterceptor {
    // MARK: - Life cycle
    public init() { }
    
    // MARK: - Method
    public func adapt(_ request: URLRequest) async throws -> URLRequest {
        /// to Delay 1 second
        try await Task.sleep(nanoseconds: 1000_000_000)
        return request
    }
}
