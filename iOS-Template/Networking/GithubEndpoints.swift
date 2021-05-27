//
//  GithubEndpoints.swift
//  iOS-Template
//
//  Created by Viranchee on 02/04/21.
//

import Foundation

enum GithubEndpoints {
  static let urlComp = URLComponents(string: Constants.githubURL)!

  static var searchUser: (String, Int) -> URL? = { query, page in
    var searchComponent = Self.urlComp
    searchComponent.path = "/search/users"
    let query = "q=\"\(query)\"&page=\(String(page))"
    searchComponent.query = query
    return searchComponent.url
  }
  
  static let getRepos: (String) -> URL? = {
    var component = Self.urlComp
    component.path = "/users/\($0)/repos"
    return component.url
  }
}
