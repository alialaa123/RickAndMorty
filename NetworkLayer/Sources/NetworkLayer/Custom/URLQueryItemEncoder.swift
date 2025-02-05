//
//  URLQueryItemEncoder.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct URLQueryItemEncoder {
    // MARK: - Methods
    public func encode<T: Encodable>(_ value: T) throws -> [URLQueryItem] {
        let data = try JSONEncoder().encode(value)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        var queryItems: [URLQueryItem] = []
        for (key, value) in dictionary ?? [:] {
            /// in case query value are array, nested dictionaries
            if let array = value as? [Any] {
                for element in array {
                    queryItems.append(URLQueryItem(name: "\(key)[]", value: "\(element)"))
                }
            } else {
                /// for normal case of key as string and value is any
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        
        return queryItems
    }
}
