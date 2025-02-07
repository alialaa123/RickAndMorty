//
//  CustomSwiftUITableViewCell.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI

class CustomSwiftUITableViewCell: UITableViewCell {
    // MARK: - make `swiftUI-view` in tableViewCell
    func makeCell<Content: View>(view: Content) {
        let controller = UIHostingController(rootView: AnyView(view))
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        contentView.addSubview(controller.view)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
