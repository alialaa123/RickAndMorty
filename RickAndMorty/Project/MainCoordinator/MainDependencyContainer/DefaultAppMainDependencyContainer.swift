//
//  AppMainDependencyContainer.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI
import Domain
import Data
import NetworkLayer

final class DefaultAppMainDependencyContainer: AppMainDependencyContainer {
    // MARK: - Methods
    func makeMainListOfCharactersView(ConfirmActions: MainListOfCharactersAction) -> UIHostingController<MainListOfCharactersView> {
        let viewModel = makeMainListOfCharactersViewModel(ConfirmActions: ConfirmActions)
        let listOfCharactersView = MainListOfCharactersView(viewModel: viewModel)
        return UIHostingController(rootView: listOfCharactersView)
    }
    
    private func makeMainListOfCharactersViewModel(ConfirmActions: MainListOfCharactersAction) -> MainListOfCharactersViewModel {
        MainListOfCharactersViewModel(
            listOfCharactersUseCase: makeListOfCharactersUseCase(),
            listOfCharactersActions: ConfirmActions
        )
    }
    
    private func makeListOfCharactersUseCase() -> ListOfCharactersUseCase {
        DefaultListOfCharactersUseCase(repository: makeListOfCharactersRepository())
    }
    
    private func makeListOfCharactersRepository() -> ListOfCharactersRepository {
        DefaultGetListOfCharactersRemote(
            networkClient: NetworkClientImplementation(
                configuration: AppEnvironmentConfiguration.development.configuration,
                requestInterceptors: AppEnvironmentConfiguration.development.requestInterceptor
            )
        )
    }
}

// MARK: - Make Character Details View
extension DefaultAppMainDependencyContainer {
    func makeCharacterDetailsView(
        with character: RickAndMortyCharacter,
        ConfirmActions: CharacterDetailsAction
    ) -> UIHostingController<CharacterDetailsView> {
        let characterDetailsView = CharacterDetailsView(
            viewModel: self.makeCharacterDetailsViewModel(
                character: character,
                characterDetailsAction: ConfirmActions
            )
        )
        return UIHostingController(rootView: characterDetailsView)
    }
    
    private func makeCharacterDetailsViewModel(
        character: RickAndMortyCharacter?,
        characterDetailsAction: CharacterDetailsAction
    ) -> CharacterDetailsViewModel {
        CharacterDetailsViewModel(
            character: character,
            characterDetailsAction: characterDetailsAction
        )
    }
}
