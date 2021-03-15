//
//  Networking.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import Foundation
struct Networking {
  private var githubUrlComp = URLComponents(string: "https://api.github.com")!
  
  enum GithubEndpoints {
    static let searchUser = "/search/users"
  }
  
  func searchUsers(query: String, page: Int = 0, closure: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
    var searchComponent = githubUrlComp
    searchComponent.path = GithubEndpoints.searchUser
    let query = "q=\"\(query)\"&page=\(String(page))"
    searchComponent.query = query
    
    guard let url = searchComponent.url else {
      closure(.failure(.urlcomponentError))
      return
    }
    dump(url)
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard error == nil else {
        closure(.failure(.apiError(error!)))
        return
      }
      guard let data = data else {
        closure(.failure(.noDataError))
        return
      }
      let decoder = JSONDecoder()
      let githubModel = try? decoder.decode(GithubModel.self, from: data)
      guard let githubModelExists = githubModel else {
        closure(.failure(.jsonDecodingError))
        return
      }
      closure(.success(githubModelExists))
    }.resume()
  }
}
