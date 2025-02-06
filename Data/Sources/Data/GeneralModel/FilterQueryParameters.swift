//
//  FilterQueryParameters.swift
//  Data
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation

public struct FilterQueryParameters: RequestQueryParameters {
    public let page: Int
    public let limit: Int
    public let status: String?
    
    public init(page: Int, limit: Int, status: String?) {
        self.page = page
        self.limit = limit
        self.status = status
    }
}
