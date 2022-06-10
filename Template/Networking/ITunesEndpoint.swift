//
//  iTunesEndpoint.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation

enum ITunesEndpoint: Endpoint {
    case getSong(searchText: String)
    case failure
    var scheme: String {
        switch self {
        default:
            return  CommandLine.arguments.contains("-debugServer") ? "http" : "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return  CommandLine.arguments.contains("-debugServer") ? "localhost" : "itunes.apple.com"
        }
    }
    
    var path: String {
        switch self {
        case .failure: return "/fail"
        case .getSong:
            return "/search"
        }
    }
    
    var port: Int? {
        switch self {
        default:
            return CommandLine.arguments.contains("-debugServer") ? 8080 : nil
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .failure:
            return []
        case .getSong(let searchTerm):
            return [URLQueryItem(name: "term", value: searchTerm), URLQueryItem(name: "media", value: "music")]
        }
    }
    
    var method: String {
        switch self {
        case .failure: return "get"
        case .getSong:
            return "get"
        }
    }
}
