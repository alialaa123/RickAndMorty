//
//  ResponseValidator.swift
//  NetworkLayer
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation

public protocol ResponseValidator: Sendable {
    func validate(_ response: HTTPURLResponse, data: Data) throws
}
