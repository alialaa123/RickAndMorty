//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI
import Domain

struct CharacterDetailsView: View {
    // MARK: - Properties
    @StateObject var viewModel: CharacterDetailsViewModel
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                ScrollView(.vertical, showsIndicators: false) {
                    CharacterPosterView(
                        characterPoster: viewModel.character?.characterImageURL,
                        posterWidth: UIScreen.main.bounds.width,
                        posterHeight: UIScreen.main.bounds.height * 0.5,
                        cornerRadius: 36
                    )
                    
                    if let character = viewModel.character {
                        CharacterDetailsInformationView(character: character)
                    }
                }
                
                InternalHeaderViewWithActionButton(buttonAction: $viewModel.shouldBeDismissed)
            }
        }
        .ignoresSafeArea()
    }
}

