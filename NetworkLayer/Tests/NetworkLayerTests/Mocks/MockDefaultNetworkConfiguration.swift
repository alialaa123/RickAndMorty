//
//  File.swift
//  NetworkLayer
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation
@testable import NetworkLayer

struct MockDefaultNetworkConfiguration: NetworkConfiguration {
    var baseURL: URL { URL(string: "https://example.com")! }
    var defaultHeaders: [String: String] { [:] }
}
