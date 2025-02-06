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
    public typealias QueryParameters = DefaultRequestQueryParameters
    
    public var path: String { "/character" }
    public var method: HTTPMethod { .get }
    public var queryParameters: DefaultRequestQueryParameters?
    
    // MARK: - Life cycle
    public init(page: Int, limit: Int) {
        self.queryParameters = QueryParameters(page: page, limit: limit)
    }
}
