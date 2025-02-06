//
//  ConvertStringToColor.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUICore

struct ConvertStringToColor {
    var color: String
    
    var colorValue: Color {
        switch color {
        case "red": return .red.opacity(0.2)
        case "orange": return .orange.opacity(0.2)
        case "purple": return .purple.opacity(0.2)
        default: return .clear
        }
    }
}
