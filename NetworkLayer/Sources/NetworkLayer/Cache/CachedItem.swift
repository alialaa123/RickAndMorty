//
//  CachedItem.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public actor CachedItem {
    // MARK: - Properties
    let data: Data
    let timeStamp: Date
    
    // MARK: - Life cycle
    public init(data: Data, timeStamp: Date = Date()) {
        self.data = data
        self.timeStamp = timeStamp
    }
}
