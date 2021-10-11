//
//  GitReposAPI.swift
//  iOS-Template
//
//  Created by Apple on 07/10/21.
//

import Foundation

protocol GitReposAPIProtocol {
    mutating func getRepos(of user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void)
}

struct GitReposAPI: GitReposAPIProtocol {
    var networking = Networking()
    
    func generateURL(for user: String) -> URL? {
        var urlComp = URLComponents(string: Constants.githubURL)!
        urlComp.path = "/users/\(user)/repos"
        return urlComp.url
    }
    
    mutating func getRepos(of user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
        let searchURL = generateURL(for: user)
        networking.genericURLSession(url: searchURL, completion: completion)
    }
}
