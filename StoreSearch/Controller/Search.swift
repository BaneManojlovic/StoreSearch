//
//  Search.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 05/08/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import Foundation

typealias SearchComplete = (Bool) -> Void
class Search {
    
    // MARK: - Enums
    enum Category: Int {
        case all = 0
        case music = 1
        case software = 2
        case ebooks = 3
        
        var type: String {
            switch self {
            case .all: return ""
            case .music: return "musicTrack"
            case .software: return "software"
            case .ebooks: return "ebook"
            }
        }
    }
    
    // MARK: - Properties
    var searchResults: [SearchResult] = []
    var hasSearched = false
    var isLoading = false
    
    // MARK: - Private Properties
    private var dataTask: URLSessionDataTask? = nil
    
    // MARK: - Methods
    func performSearch(for text: String, category: Category, completion: @escaping SearchComplete) {
        print("Searching...")
        
        if !text.isEmpty {
            dataTask?.cancel()
            
            isLoading = true
            hasSearched = true
            searchResults = []
            
            let url = iTunesURL(searchText: text, category: category)
            
            let session = URLSession.shared
            
            dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
                var success = false
                    // Was search cancelled?
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    self.searchResults = self.parse(data: data)
                    self.searchResults.sort(by: <)
                    
                    print("Success!")
                    self.isLoading = false
                    success = true
                }
                
                if !success {
                    self.hasSearched = false
                    self.isLoading = false
                }
                
                DispatchQueue.main.async {
                    completion(success)
                }
                
//                print("Failure! \(response!)")
//                self.hasSearched = false
//                self.isLoading = false
                
            })
            dataTask?.resume()
        }
    }
    
    // MARK: - Helper Methods
    private func iTunesURL(searchText: String, category: Category) -> URL {
        let kind: String
        switch category {
        case .all: kind = ""
        case .music: kind = "musicTrack"
        case .software: kind = "software"
        case .ebooks: kind = "ebook"
        }
        
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = "https://itunes.apple.com/search?" + "term=\(encodedText)&limit=200&entity=\(kind)"
        let url = URL(string: urlString)
        return url!
    }
    
    private func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.results
        } catch {
            print("JSON error: \(error)")
            return []
        }
    }
}