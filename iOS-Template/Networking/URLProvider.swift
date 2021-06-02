//
//  URLProvider.swift
//  iOS-Template
//
//  Created by apple on 28/05/21.
//

import Foundation

struct URLProvider {
  
  private let components: URLComponents = {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.github.com"
    return components
  }()
  
  /// Makes a URL for searching GitHub for the search string provided and the page number of the expected results.
  func makeSearchURL(query: String, page: Int) -> URL? {
    var components = self.components
    components.path = "/search/users"
    components.queryItems = [
      URLQueryItem(name: "q", value: "\"\(query)\""),
      URLQueryItem(name: "page", value: String(describing: page))
    ]
    return components.url
  }
  
  /// Makes a URL for fetching repositories belonging to the provided user.
  func makeReposURL(for user: GithubUser) -> URL? {
    var components = self.components
    components.path = "/users/\(user.login)/repos"
    return components.url
  }
  
}
