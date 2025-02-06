//
//  MainHeaderView.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI

struct MainHeaderView: View {
    // MARK: - Properties
    let headerTitle: String
    
    // MARK: - View
    var body: some View {
        HStack {
            Text(headerTitle)
                .font(.largeTitle.weight(.semibold))
            Spacer()
        }
    }
}
