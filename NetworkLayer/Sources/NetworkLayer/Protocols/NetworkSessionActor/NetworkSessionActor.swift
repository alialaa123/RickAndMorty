//
//  NetworkSessionActor.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public protocol NetworkSessionActor: Actor {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
