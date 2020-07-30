//
//  ViewController.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 30/07/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    // MARK: - Helper Struct
    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupDelegates()
    }
    
    func setupUI() {
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        // registering tableview cells
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        
    }
    
    func setupDelegates() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// MARK: - Conforming to UISearchBarDelegate procotol
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The text is: \(searchBar.text!)")
        
        searchResults = []
        
        if searchBar.text! != "justin bieber" {
            for i in 0...2 {
                
                let searchResult = SearchResult()
                searchResult.name = String(format: "Fake result %d for", i)
                searchResult.artistName = searchBar.text!
                
                searchResults.append(searchResult)
            }
        }
        
        hasSearched = true
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}


// MARK: - Conforming to UITableViewDataSource
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Handle no search results for tableview
        if searchResults.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            cell.artistNameLabel.text = searchResult.artistName
            return cell
        }
    }
    
}

// MARK: - Conforming to UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
