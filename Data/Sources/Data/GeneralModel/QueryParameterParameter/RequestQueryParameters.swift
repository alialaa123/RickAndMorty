//
//  RequestQueryParameters.swift
//  Data
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation

public protocol RequestQueryParameters: Sendable, Encodable {
    var page: Int { get }
    var limit: Int { get }
}
