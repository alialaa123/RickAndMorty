//
//  CharacterGenderDTO.swift
//  Data
//
//  Created by ali alaa on 05/02/2025.
//

import Foundation
import Domain

public enum CharacterGenderDTO: String, Decodable, Sendable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown
    
    // MARK: - Method
    public func toDomain() -> CharacterGender {
        CharacterGender(rawValue: self.rawValue.lowercased()) ?? .unknown
    }
}
