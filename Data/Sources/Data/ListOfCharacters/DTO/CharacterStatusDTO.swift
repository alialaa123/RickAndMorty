//
//  CharacterStatusDTO.swift
//  Data
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation
import Domain

public enum CharacterStatusDTO: String, Decodable, Sendable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
    // MARK: - Method
    public func toDomain() -> Domain.CharacterStatus {
        CharacterStatus(rawValue: self.rawValue.lowercased()) ?? .unknown
    }
}
