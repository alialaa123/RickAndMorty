//
//  MainListOfCharactersView.swift
//  RickAndMorty
//
//  Created by ali alaa on 04/02/2025.
//

import SwiftUI
import Data
import NetworkLayer
import Domain

struct MainListOfCharactersView: View {
    // MARK: - Properties
    @StateObject var viewModel: MainListOfCharactersViewModel
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 12) {
            topHeaderContent
            
            BottomContent
        }
        .padding()
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    // MARK: - view Content
    var topHeaderContent: some View {
        VStack(spacing: 12) {
            MainHeaderView(headerTitle: "Characters")
            
            FilterationView(
                filterTabSelected: $viewModel.filterTabsSelected
            )
        }
    }
    
    var BottomContent: some View {
        ZStack(alignment: .top) {
            if let characters = viewModel.characters {
                TableViewRepresentable(
                    items: characters,
                    selectedItem: $viewModel.characterSelected,
                    loadNextPage: $viewModel.shouldLoadNextPage
                )
            }
            
            /// Loading
            if viewModel.isLoading {
                CustomProgressView()
            }
            
            /// Error view if found
            if viewModel.shouldShowError {
                ErrorMessageView(errorMessage: viewModel.errorMessage)
            }
        }
        .frame(maxHeight: .infinity)
    }
}
