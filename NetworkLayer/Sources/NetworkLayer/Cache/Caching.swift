//
//  File.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public protocol Caching: Sendable {
    func insertCacheData<T: Sendable>(_ data: T, for key: String?) async
    func getCachedData<T: Sendable>(_ key: String?) async -> T?
    func invalidateCache<T: Sendable>(_ data: T) async
}
