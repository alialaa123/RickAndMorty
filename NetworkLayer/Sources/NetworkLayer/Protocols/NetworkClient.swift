//
//  NetworkClientProtocol.swift
//  NetworkLayer
//
//  Created by ali alaa on 04/02/2025.
//

import Foundation

public protocol NetworkClient: Sendable {
    func send<Request: NetworkRequest>(_ request: Request) async throws -> Request.Response
}
