//
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation
import Domain
import Combine

final class CharacterDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var character: RickAndMortyCharacter?
    @Published var shouldBeDismissed: Bool = false
    
    /// Actions
    var characterDetailsAction: CharacterDetailsAction
    
    /// AnyCancellable
    var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    init(
        character: RickAndMortyCharacter?,
        characterDetailsAction: CharacterDetailsAction
    ) {
        self.character = character
        self.characterDetailsAction = characterDetailsAction
        observeShouldBeDismiss()
    }
    
    // MARK: - Methods
    func observeShouldBeDismiss() {
        $shouldBeDismissed
            .receive(on: RunLoop.main)
            .sink { [weak self] shouldDismiss in
                guard let self, shouldDismiss == true else { return }
                self.characterDetailsAction.dismiss()
            }
            .store(in: &cancellable)
    }
}
