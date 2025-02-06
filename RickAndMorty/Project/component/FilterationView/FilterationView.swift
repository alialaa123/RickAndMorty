//
//  FilterationView.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI

struct FilterationView: View {
    // MARK: - Properties
    var filterTabs = FilterCharacterStatus.allCases
    @Binding var filterTabSelected: FilterCharacterStatus?
    
    // MARK: - View
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(filterTabs, id: \.self) { tab in
                    VStack {
                        Button {
                            filterTabSelected = tab
                        } label: {
                            Text(tab.title.capitalized)
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(.gray, lineWidth: 1)
                    )
                }
            }
        }
    }
}

#Preview {
    FilterationView(
        filterTabSelected: .constant(.alive)
    )
}
