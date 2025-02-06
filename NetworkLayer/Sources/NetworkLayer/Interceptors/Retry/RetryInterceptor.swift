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
    private let requestInterceptor: RequestInterceptor
    
    // MARK: - Life cycle
    public init(
        maxRetryCount: Int = 3,
        requestInterceptor: RequestInterceptor = DefaultRequestInterceptor()
    ) {
        self.maxRetryCount = maxRetryCount
        self.requestInterceptor = requestInterceptor
    }
    
    // MARK: - Methods
    public func adapt(_ request: URLRequest) async throws -> URLRequest {
        var retryCount = 0
        var lastError: Error?
        
        repeat {
            retryCount += 1
            do {
                return try await requestInterceptor.adapt(request)
            } catch {
                lastError = error
                /// this to allow other tasks to run
                /// by Suspended this task
                await Task.yield()
            }
        } while retryCount < maxRetryCount
        
        throw lastError ?? NetworkError.requestFailed(NSError())
    }
}
