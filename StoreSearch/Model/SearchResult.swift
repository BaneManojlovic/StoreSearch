//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 30/07/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

class ResultArray: Codable {
    
    // MARK: - Properties
    var resultCount = 0
    var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible {
    
    // MARK: - Enums
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case storeURL = "trackViewUrl"
        case genre = "primaryGenreName"
        case kind, artistName, trackName
        case trackPrice, currency
    }
  
    // MARK: - Properties
    var artistName: String? = ""
    var trackName: String? = ""
    var kind: String? = ""
    var trackPrice: Double? = 0.0
    var currency = ""
    var imageSmall = ""
    var imageLarge = ""
    var storeURL: String? = ""
    var genre = ""
    
    var name: String {
        return trackName ?? ""
    }
    // Propety needed for Conforming to CustomStringConvertible protocol
    var description: String {
        return "Kind: \(kind ?? "None"), Name: \(name), Artist name: \(artistName ?? "None")"
    }
}

