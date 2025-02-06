//
//  AppMainCoordinator.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import UIKit
import SwiftUI
import Domain

final class AppMainCoordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController = UINavigationController()
    
    /// Long-lived Properties
    private let window: UIWindow
    private let dependencyContainer: AppMainDependencyContainer
    
    // MARK: - Life cycle
    init(window: UIWindow, dependencyContainer: AppMainDependencyContainer) {
        self.window = window
        self.dependencyContainer = dependencyContainer
    }
    
    // MARK: - Methods
    func start() {
        let rootView = dependencyContainer.makeMainListOfCharactersView(ConfirmActions: self)
        
        navigationController.pushViewController(rootView, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navigationController
    }
}

// MARK: - List Of Characters Actions
extension AppMainCoordinator: MainListOfCharactersAction {
    func openCharacterDetails(for character: RickAndMortyCharacter) {
        let characterDetailsView = dependencyContainer.makeCharacterDetailsView(with: character, ConfirmActions: self)
        navigationController.pushViewController(characterDetailsView, animated: true)
    }
}

// MARK: - Characters Details View Action
extension AppMainCoordinator: CharacterDetailsAction {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
