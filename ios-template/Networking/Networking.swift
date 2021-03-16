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
  
  func genericURLSession<A>(urlComponent: URLComponents, decoder: @escaping (Data) -> A?, completion: @escaping (Result<A, NetworkingError>) -> Void) {
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
      
      let model: A? = decoder(data)
      
      guard let modelExists = model else {
        completion(.failure(.jsonDecodingError))
        return
      }
      completion(.success(modelExists))
    }.resume()
    
  }
  
  func genericURLSession<A: Decodable>(urlComponent: URLComponents, completion: @escaping (Result<A, NetworkingError>) -> Void) {
    genericURLSession(urlComponent: urlComponent) { (data) -> A? in
      return try? JSONDecoder().decode(A.self, from: data)
    } completion: { completion($0) }

  }
  
  func getRepos(user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
    var searchComponent = githubUrlComp
    searchComponent.path = GithubEndpoints.getRepos(user)
    
    genericURLSession(urlComponent: searchComponent, completion: completion)
    
  }
  
  func searchUsers(query: String, page: Int = 1, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
    var searchComponent = githubUrlComp
    searchComponent.path = GithubEndpoints.searchUser
    let query = "q=\"\(query)\"&page=\(String(page))"
    searchComponent.query = query
    
    genericURLSession(urlComponent: searchComponent, completion: completion)
  }
  
  func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) {
    let urlComponents = URLComponents(string: url.absoluteString)!
    genericURLSession(urlComponent: urlComponents) { (data) -> UIImage? in
      return UIImage(data: data)
    } completion: { completion($0) }

  }
}
