//
//  RetryInterceptor.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct RetryInterceptor: RequestInterceptor {
    // MARK: - Properties
    private let maxRetryCount: Int
    
    // MARK: - Life cycle
    public init(maxRetryCount: Int = 3) {
        self.maxRetryCount = maxRetryCount
    }
    
    // MARK: - Methods
    public func adapt(_ request: URLRequest) async throws -> URLRequest {
        var retryCount = 0
        var lastError: Error?
        
        repeat {
            retryCount += 1
            do {
                return try await performRequest(request)
            } catch {
                lastError = error
                /// this to allow other tasks to run
                /// by Suspended this task
                await Task.yield()
            }
        } while retryCount <= maxRetryCount
        
        throw lastError ?? NetworkError.requestFailed(NSError())
    }
    
    private func performRequest(_ request: URLRequest) async throws -> URLRequest {
        /// to Delay 1 second
        try await Task.sleep(nanoseconds: 1000_000_000)
        return request
    }
}
