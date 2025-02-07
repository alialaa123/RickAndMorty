//
//  DefaultResponseValidator.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public struct DefaultResponseValidator: ResponseValidator {
    /// Static property for the default validator
    public static let `default` = DefaultResponseValidator()
    
    // MARK: - Method
    /// To use as Default validator for most of requests
    /// in the NetworkRequest, can give it the default with also ability to able a custom validate
    public func validate(_ response: HTTPURLResponse, data: Data) throws {
        guard 200..<300 ~= response.statusCode else {
            throw NetworkError.serverError(statusCode: response.statusCode, error: nil)
        }
    }
}
