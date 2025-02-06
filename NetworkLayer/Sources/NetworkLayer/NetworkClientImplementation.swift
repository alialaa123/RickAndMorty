//
//  File.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public actor NetworkClientImplementation: NetworkClient {
    // MARK: - Properties
    private let configuration: NetworkConfiguration
    private let session: NetworkSessionActor
    private let requestInterceptors: [RequestInterceptor]
    private let responseInterceptors: [ResponseInterceptor]
    private let decoder: JSONDecoder
    
    /// Cache for URLRequests
    private var urlRequestCache: [String: URLRequest] = [:]
    private let cacheResponse: Caching?
    
    // MARK: - Life cycle
    public init(
        configuration: NetworkConfiguration,
        session: NetworkSessionActor = DefaultURLSessionActor(),
        requestInterceptors: [RequestInterceptor] = [],
        responseInterceptors: [ResponseInterceptor] = [],
        decoder: JSONDecoder = JSONDecoder(),
        cacheResponse: Caching? = nil
    ) {
        self.configuration = configuration
        self.session = session
        self.requestInterceptors = requestInterceptors
        self.responseInterceptors = responseInterceptors
        self.decoder = decoder
        self.cacheResponse = cacheResponse
    }
    
    // MARK: - Methods
    public func send<Request: NetworkRequest>(_ request: Request) async throws -> Request.Response {
        /// Generate the cache Key
        let cacheKey = generateCacheKey(request)
        
        /// Check for a cached response
        if let cachedData: Data = await cacheResponse?.getCachedData(cacheKey) {
            /// retrieve the cached data
            return try decoder.decode(Request.Response.self, from: cachedData)
        }
        
        /// IF no CachedData for request,
        /// Check Cache for URLRequest
        /// If exist fire from the Cached one, better for performance than creating new Request instance
        if let cachedURLRequest = urlRequestCache[cacheKey] {
            return try await executeRequest(cachedURLRequest, for: request)
        }
        
        let urlRequest = try buildURLRequest(for: request)
        
        /// Caching the URLRequest
        urlRequestCache[cacheKey] = urlRequest
        
        return try await executeRequest(urlRequest, for: request)
    }
    
    // MARK: - Request builder
    private func buildURLRequest<Request: NetworkRequest>(for request: Request) throws -> URLRequest {
        let url = configuration.baseURL.appendingPathComponent(request.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        /// Encode QueryParameters
        if let queryParameters = request.queryParameters {
            let encoder = URLQueryItemEncoder()
            components.queryItems = try encoder.encode(queryParameters)
        }
        
        /// Validate the URL
        guard let requestURL = components.url else {
            throw NetworkError.invalidURL
        }
        
        /// Combine headers
        var headers = configuration.defaultHeaders
        if let customHeaders = request.customHeaders {
            headers.merge(customHeaders) { $1 }
        }
        
        /// Create the URLRequest
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = 10
        urlRequest.httpBody = request.body
        
        return urlRequest
    }
    
    // MARK: - Execute Request
    private func executeRequest<Request: NetworkRequest>(
        _ urlRequest: URLRequest,
        for request: Request
    ) async throws -> Request.Response {
        var urlRequest = urlRequest
        
        /// Apply Request Interceptors
        for interceptor in requestInterceptors {
            urlRequest = try await interceptor.adapt(urlRequest)
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        try request.validator.validate(httpResponse, data: data)
        
        /// Apply Response Interceptors
        var processedData = data
        for interceptor in responseInterceptors {
            processedData = try await interceptor.process(data: processedData, response: httpResponse)
        }
        
        /// Cache the response
        let cacheKey = generateCacheKey(request)
        if let responseData = try? JSONEncoder().encode(processedData) {
            await cacheResponse?.insertCacheData(responseData, for: cacheKey)
        }
        
        do {
            return try decoder.decode(Request.Response.self, from: processedData)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

// MARK: - Generate Cache Key
extension NetworkClientImplementation {
    private func generateCacheKey<Request: NetworkRequest>(_ request: Request) -> String {
        let requestId = ObjectIdentifier(Request.self).hashValue
        let queryParametersKey = request.queryParameters
        
        return "\(requestId)-\(String(describing: queryParametersKey))"
    }
}
