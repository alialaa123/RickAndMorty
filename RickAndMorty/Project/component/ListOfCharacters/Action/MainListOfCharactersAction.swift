//
//  MainListOfCharactersAction.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import Domain

protocol MainListOfCharactersAction: Sendable {
    func openCharacterDetails(for character: RickAndMortyCharacter)
}
