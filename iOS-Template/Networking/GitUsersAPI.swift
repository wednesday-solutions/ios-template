//
//  GitUsers+API.swift
//  iOS-Template
//
//  Created by Apple on 07/10/21.
//

import Foundation

protocol GitUserAPIProtocol {
    mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void)
}

struct GitUsersAPI: GitUserAPIProtocol {
    var networking = Networking()
    
    func generateURL(for user: String, page: Int) -> URL? {
        let urlComp = URLComponents(string: Constants.githubURL)!
        var searchComponent = urlComp
        searchComponent.path = "/search/users"
        let query = "q=\"\(user)\"&page=\(String(page))"
        searchComponent.query = query
        return searchComponent.url
    }
    
    mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
        let searchURL = generateURL(for: query, page: page)
        networking.genericURLSession(url: searchURL, completion: completion)
    }
}
