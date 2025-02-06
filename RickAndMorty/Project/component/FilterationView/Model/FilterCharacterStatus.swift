//
//  FilterCharacterStatus.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation
import Domain

enum FilterCharacterStatus: String, CaseIterable {
    // MARK: - character Cases
    case alive
    case dead
    case unknown

    // MARK: - Properties
    var title: String {
        switch self {
        case .alive: return "Alive"
        case .dead: return "Dead"
        case .unknown: return "Unknown"
        }
    }
    
    /// convert to `DomainModel` to keep consistent of source data
    var convertToDomain: CharacterStatus {
        CharacterStatus(rawValue: self.rawValue) ?? .unknown
    }
}
