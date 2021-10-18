//
//  iTunesEndpoint.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation

enum ITunesEndpoint: Endpoint {
    case getSong(searchText: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "itunes.apple.com"
        }
    }
    
    var path: String {
        switch self {
        case .getSong:
            return "search"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .getSong(let searchTerm):
            return [URLQueryItem(name: "term", value: searchTerm)]
        }
    }
    
    var method: String {
        switch self {
        case .getSong:
            return "get"
        }
    }
}
