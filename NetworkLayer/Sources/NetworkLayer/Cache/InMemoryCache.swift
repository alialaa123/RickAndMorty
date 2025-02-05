//
//  InMemoryCache.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public actor InMemoryCache: Caching {
    // MARK: - Properties
    private let cache = NSCache<NSString, CachedItem>()
    private let expirationInterval: TimeInterval
    
    // MARK: - Life cycle
    /// Giving default expiration Cache: 5 min
    /// And Caching up to 20 items which first page items
    public init (expirationInterval: TimeInterval = 300, maxCacheSize: Int = 20) {
        self.expirationInterval = expirationInterval
        self.cache.countLimit = maxCacheSize
    }
    
    public func insertCacheData<T: Sendable>(_ data: T, for key: String?) {
        guard let key = key, let data = data as? Data else { return }
        let cachedItem = CachedItem(data: data, timeStamp: Date())
        cache.setObject(cachedItem as CachedItem, forKey: key as NSString)
    }
    
    public func getCachedData<T: Sendable>(_ key: String?) -> T? {
        guard let key = key as? NSString,
              let cachedItem = cache.object(forKey: key) else {
            return nil
        }
        
        if Date().timeIntervalSince(cachedItem.timeStamp) > expirationInterval {
            invalidateCache(String(key))
            return nil
        }
        
        return cachedItem.data as? T
    }
    
    public func invalidateCache<T: Sendable>(_ data: T) {
        guard let key = data as? NSString else { return }
        cache.removeObject(forKey: key)
    }
}
