//
//  InternalHeaderViewWithActionButton.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI

enum HeaderButtonIcon: String {
    case back = "arrow.left"
    case close = "xmark.circle.fill"
}

struct InternalHeaderViewWithActionButton: View {
    // MARK: - Properties
    var buttonIcon: HeaderButtonIcon = .back
    @Binding var buttonAction: Bool
    
    // MARK: - View
    var body: some View {
        HStack {
            Button {
                buttonAction = true
            } label: {
                VStack {
                    Image(systemName: buttonIcon.rawValue)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .frame(width: 60, height: 60)
                .background(Color.white)
                .foregroundStyle(.black)
                .clipShape(Circle())
                .padding(.top, 80)
                .padding(.leading, 26)
                .shadow(color: .white, radius: 12)
            }
            
            Spacer()
        }
    }
}

#Preview {
    InternalHeaderViewWithActionButton(buttonAction: .constant(false))
}
