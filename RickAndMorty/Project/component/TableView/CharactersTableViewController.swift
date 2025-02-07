//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by ali alaa on 07/02/2025.
//

import UIKit
import Domain

final class CharactersTableViewController<T: Sendable>: UITableViewController {
    // MARK: - Properties
    var items: [T] = []
    var loadNextPage: (() -> Void)?
    var selectedItem: ((T) -> Void)?
    
    // MARK: - Life cycle
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomSwiftUITableViewCell.self, forCellReuseIdentifier: "CustomSWIFTUICell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: - tableView Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CustomSWIFTUICell",
            for: indexPath
        ) as! CustomSwiftUITableViewCell
        
        cell.selectionStyle = .none
        
        let converterCell = CharacterTableViewCell(
            character: items[indexPath.row] as! RickAndMortyCharacter
        )
        cell.makeCell(view: converterCell)
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            loadNextPage?()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem?(items[indexPath.row])
    }
}
