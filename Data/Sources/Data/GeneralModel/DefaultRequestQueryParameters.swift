//
//  DefaultRequestQueryParameters.swift
//  Data
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct DefaultRequestQueryParameters: RequestQueryParameters {
    public let page: Int
    public let limit: Int
    
    public init(page: Int, limit: Int = 20) {
        self.page = page
        self.limit = limit
    }
}
