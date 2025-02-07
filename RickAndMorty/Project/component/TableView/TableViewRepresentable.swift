//
//  TableViewRepresentable.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI
import UIKit
import Domain

struct TableViewRepresentable<T: Sendable>: UIViewControllerRepresentable {
    // MARK: - Properties
    var items: [T] = []
    var loadNextPage: (() -> Void)?
    var selectedItem: ((T) -> Void)?
    
    // MARK: - UIViewRepresentable Delegate methods
    func makeUIViewController(context: Context) -> CharactersTableViewController<T> {
        let tableView = CharactersTableViewController<T>()
        tableView.items = items
        tableView.selectedItem = selectedItem
        tableView.loadNextPage = loadNextPage
        return tableView
    }
    
    func updateUIViewController(_ uiViewController: CharactersTableViewController<T>, context: Context) {
        uiViewController.items = items
        uiViewController.tableView.reloadData()
    }
}
