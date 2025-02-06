//
//  FetchListOfCharactersRequest.swift
//  Data
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation
import NetworkLayer
import Domain

public struct FetchListOfCharactersRequest: NetworkRequest {
    public typealias Response = ListOfCharactersResponseDTO
    public typealias ErrorType = NetworkError
    public typealias QueryParameters = FilterQueryParameters
    
    public var path: String { "/character" }
    public var method: HTTPMethod { .get }
    public var queryParameters: FilterQueryParameters?
    
    // MARK: - Life cycle
    public init(page: Int, limit: Int, status: String? = nil) {
        self.queryParameters = FilterQueryParameters(page: page, limit: limit, status: status)
    }
}
