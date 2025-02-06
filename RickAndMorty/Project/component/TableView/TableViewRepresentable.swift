//
//  TableViewRepresentable.swift
//  RickAndMorty
//
//  Created by ali alaa on 06/02/2025.
//

import SwiftUI
import UIKit
import Domain

struct TableViewRepresentable<T: Sendable>: UIViewRepresentable {
    // MARK: - Properties
    var items: [T]?
    @Binding var selectedItem: T?
    @Binding var loadNextPage: Bool
    
    // MARK: - UIViewRepresentable Delegate methods
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.register(CustomSwiftUITableViewCell.self, forCellReuseIdentifier: "CustomSWIFTUICell")
        
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        let existingCharactersCount = context.coordinator.items?.count ?? 0
        let newCharactersCount = items?.count ?? 0
        
        context.coordinator.items = items
        
        if newCharactersCount > existingCharactersCount {
            let indexPaths = (existingCharactersCount..<newCharactersCount).map { IndexPath(row: $0, section: 0) }
            uiView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            items: items,
            selectedItem: $selectedItem,
            loadNextPage: $loadNextPage
        )
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        var items: [T]?
        @Binding var selectedItem: T?
        @Binding var loadNextPage: Bool
        
        init(
            items: [T]?,
            selectedItem: Binding<T?>,
            loadNextPage: Binding<Bool>
        ) {
            self.items = items
            self._selectedItem = selectedItem
            self._loadNextPage = loadNextPage
        }
        
        func tableView(
            _ tableView: UITableView,
            numberOfRowsInSection section: Int
        ) -> Int {
            items?.count ?? 0
        }
        
        func tableView(
            _ tableView: UITableView,
            cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "CustomSWIFTUICell",
                for: indexPath
            ) as! CustomSwiftUITableViewCell
            
            let converterCell = CharacterTableViewCell(
                character: items?[indexPath.row] as! RickAndMortyCharacter
            )
            cell.makeCell(view: converterCell)
            return cell
        }
        
        func tableView(
            _ tableView: UITableView,
            didSelectRowAt indexPath: IndexPath
        ) {
            selectedItem = items?[indexPath.row]
        }
        
        func tableView(
            _ tableView: UITableView,
            willDisplay cell: UITableViewCell,
            forRowAt indexPath: IndexPath
        ) {
            if indexPath.row == (items?.count ?? 0) - 5 && !loadNextPage {
                loadNextPage = true
            }
        }
    }
}
