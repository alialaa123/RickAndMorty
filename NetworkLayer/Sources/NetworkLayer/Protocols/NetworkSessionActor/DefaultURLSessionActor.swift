//
//  DefaultURLSessionActor.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public actor DefaultURLSessionActor: NetworkSessionActor {
    // MARK: - Property
    private let session: URLSession
    
    // MARK: - Life cycle
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Method
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}
