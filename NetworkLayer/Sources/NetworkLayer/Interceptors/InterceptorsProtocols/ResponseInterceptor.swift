//
//  ResponseInterceptor.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public protocol ResponseInterceptor: Sendable {
    func process(data: Data, response: HTTPURLResponse) async throws -> Data
}
