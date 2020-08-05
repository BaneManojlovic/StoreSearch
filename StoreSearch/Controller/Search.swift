//
//  Search.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 05/08/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import Foundation

class Search {
    
    // MARK: - Properties
    var searchResults: [SearchResult] = []
    var hasSearched = false
    var isLoading = false
    
    // MARK: - Private Properties
    private var dataTask: URLSessionDataTask? = nil
    
    // MARK: - Methods
    func performSearch(for text: String, category: Int) {
        print("Searching...")
    }
}
