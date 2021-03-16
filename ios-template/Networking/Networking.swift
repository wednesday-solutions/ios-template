//
//  Networking.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit
struct Networking {
  private var githubUrlComp = URLComponents(string: "https://api.github.com")!
  
  enum GithubEndpoints {
    static let searchUser = "/search/users"
    static let getRepos: (String) -> String = { return "/users/\($0)/repos" }
  }
  
  func genericURLSession<A: Decodable>(urlComponent: URLComponents, completion: @escaping (Result<A, NetworkingError>) -> Void) {
    guard let url = urlComponent.url else {
      completion(.failure(.urlcomponentError))
      return
    }
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard error == nil else {
        completion(.failure(.apiError(error!)))
        return
      }
      guard let data = data else {
        completion(.failure(.noDataError))
        return
      }
      let decoder = JSONDecoder()
      let model: A? = try? decoder.decode(A.self, from: data)
      
      guard let modelExists = model else {
        completion(.failure(.jsonDecodingError))
        return
      }
      completion(.success(modelExists))
    }.resume()
    
  }
  
  func getRepos(user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
    var searchComponent = githubUrlComp
    searchComponent.path = GithubEndpoints.getRepos(user)

    genericURLSession(urlComponent: searchComponent) { result in
      completion(result)
    }
    
  }
  
  func searchUsers(query: String, page: Int = 1, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
    var searchComponent = githubUrlComp
    searchComponent.path = GithubEndpoints.searchUser
    let query = "q=\"\(query)\"&page=\(String(page))"
    searchComponent.query = query
    
    genericURLSession(urlComponent: searchComponent) { result in
      completion(result)
    }
  }
  
  func getImage(url: URL, callback: @escaping (UIImage) -> Void) {
    fatalError()
  }
}
