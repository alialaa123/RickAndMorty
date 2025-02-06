//
//  AppMainDependencyContainer.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI
import Domain

protocol AppMainDependencyContainer: Sendable {
    func makeMainListOfCharactersView(
        ConfirmActions: MainListOfCharactersAction
    ) -> UIHostingController<MainListOfCharactersView>
    
    func makeCharacterDetailsView(
        with character: RickAndMortyCharacter,
        ConfirmActions: CharacterDetailsAction
    ) -> UIHostingController<CharacterDetailsView>
}
