//
//  LoggingInterceptor.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct LoggingInterceptor: RequestInterceptor, ResponseInterceptor {
    // MARK: - Methods
    /// Log Request for easy Debugging
    public func adapt(_ request: URLRequest) async throws -> URLRequest {
        print("REQUEST_DEBUG: Outgoing Request: \(request.url?.absoluteString ?? "")")
        print("REQUEST_DEBUG: Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("REQUEST_DEBUG: ------------------ \n")
        if let body = request.httpBody {
            print("REQUEST_DEBUG: Body: \(String(data: body, encoding: .utf8) ?? "")")
        }
        
        return request
    }
    
    /// Log Response for easy Debugging
    public func process(data: Data, response: HTTPURLResponse) async throws -> Data {
        print("RESPONSE_DEBUG: Incoming Response: \(response.statusCode)")
        print("RESPONSE_DEBUG: Body: \(String(data: data, encoding: .utf8) ?? "")")
        
        return data
    }
}
