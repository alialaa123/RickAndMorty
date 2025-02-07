//
//  MainListOfCharactersViewModel.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import Foundation
import Domain
import Combine

final class MainListOfCharactersViewModel: ObservableObject {
    // MARK: - Properties
    @Published var characters: [RickAndMortyCharacter]?
    @Published var characterSelected: RickAndMortyCharacter?
    
    /// Filter
    @Published var filterTabsSelected: FilterCharacterStatus?
    
    /// Error
    @Published var shouldShowError: Bool = false
    @Published var errorMessage: String?
    
    /// page
    @Published var shouldLoadNextPage: Bool = false
    @Published var isLoading: Bool = false
    private var currentPage = 1
    
    /// UseCase
    private let listOfCharactersUseCase: ListOfCharactersUseCase
    
    /// Actions
    private let listOfCharactersActions: MainListOfCharactersAction
    private var canLoadMoreCharacters = true
    
    /// AnyCancellable
    private var cancellable = Set<AnyCancellable>()
    
    /// Task for fetchCharacters
    private var fetchCharactersTask: Task<Void, Never>?
    
    // MARK: - Life cycle
    init(
        listOfCharactersUseCase: ListOfCharactersUseCase,
        listOfCharactersActions: MainListOfCharactersAction
    ) {
        self.listOfCharactersUseCase = listOfCharactersUseCase
        self.listOfCharactersActions = listOfCharactersActions
        getListOfCharacters()

        /// Observable for Actions
        observationFilterSelected()
        observationLoadNextPage()
        observationCharacterSelected()
    }
    
    deinit {
        fetchCharactersTask?.cancel()
    }
    
    // MARK: - Methods
    private func getListOfCharacters() {
        guard !isLoading, canLoadMoreCharacters else { return }
        isLoading = true
        fetchCharactersTask = Task { [weak self] in
            guard let self else { return }
            do {
                canLoadMoreCharacters = false
                let listOfCharacters = try await listOfCharactersUseCase.execute(
                    with: filterTabsSelected?.convertToDomain.rawValue,
                    page: currentPage
                )
                await successResponse(of: listOfCharacters)
            } catch let error {
                await failureResponse(with: error)
            }
        }
    }
    
    private func loadNextPage() {
        guard shouldLoadNextPage else { return }
        currentPage += 1
        shouldShowError = false
        getListOfCharacters()
    }
    
    private func resetAndLoadListOfCharacters() {
        resetView()
        getListOfCharacters()
    }
    
    private func resetView() {
        currentPage = 1
        characters = nil
        shouldShowError = false
        errorMessage = nil
    }
    
    // MARK: - Responses
    @MainActor
    private func successResponse(of listOfCharacters: [RickAndMortyCharacter]) {
        if let existCharacters = characters {
            characters = NSOrderedSet(array: existCharacters + listOfCharacters).array as? [RickAndMortyCharacter]
        } else {
            characters = listOfCharacters
        }
        isLoading = false
        shouldShowError = false
        shouldLoadNextPage = false
        canLoadMoreCharacters = true
    }
    
    @MainActor
    private func failureResponse(with error: Error) {
        isLoading = false
        shouldLoadNextPage = false
        shouldShowError = true
        canLoadMoreCharacters = true
        errorMessage = error.localizedDescription
    }
}

// MARK: - Observable Actions
extension MainListOfCharactersViewModel {
    private func observationFilterSelected() {
        $filterTabsSelected
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                guard let self, value != nil else { return }
                self.resetAndLoadListOfCharacters()
                
            }
            .store(in: &cancellable)
    }
    
    private func observationCharacterSelected() {
        $characterSelected
            .receive(on: RunLoop.main)
            .sink { [weak self] character in
                guard let self,
                      let characterSelected = character else {
                    return
                }
                self.listOfCharactersActions.openCharacterDetails(for: characterSelected)
            }
            .store(in: &cancellable)
    }
    
    private func observationLoadNextPage() {
        $shouldLoadNextPage
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] shouldLoadNextPage in
                guard let self, shouldLoadNextPage else {
                    return
                }
                self.loadNextPage()
            }
            .store(in: &cancellable)
    }
}
