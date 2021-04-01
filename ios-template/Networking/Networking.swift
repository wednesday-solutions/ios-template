//
//  Networking.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

protocol Endpoints {
  func copy() -> Self
  mutating func getRepos(user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void)
  mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void)
  mutating func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> Void)
}

enum GithubEndpoints {
  static let searchUser = "/search/users"
  static let getRepos: (String) -> String = { return "/users/\($0)/repos" }
  static let urlComp = URLComponents(string: Constants.githubURL)!
}

struct Networking {
  
  private var currentNetworkRequest: URLSessionDataTask?
  
  init() {
    currentNetworkRequest = nil
  }
  
  @discardableResult
  private func genericURLSession<A>(urlComponent: URLComponents, decoder: @escaping (Data) -> A?, completion: @escaping (Result<A, NetworkingError>) -> Void) -> URLSessionDataTask? {
    guard let url = urlComponent.url else {
      completion(.failure(.urlcomponentError))
      return nil
    }
    let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard error == nil else {
        if let urlError = error as? URLError {
          completion(.failure(.urlError(urlError)))
        } else {
          completion(.failure(.apiError(error!)))
        }
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
    }
    dataTask.resume()
    return dataTask
  }
  
  private func genericURLSession<A: Decodable>(urlComponent: URLComponents, completion: @escaping (Result<A, NetworkingError>) -> Void) -> URLSessionDataTask? {
    let dataTask = genericURLSession(urlComponent: urlComponent) { (data) -> A? in
      return try? JSONDecoder().decode(A.self, from: data)
    } completion: { completion($0) }
    return dataTask
  }
  
  private func cancelCurrentRequest() {
    if self.currentNetworkRequest?.state == .some(.running) {
      self.currentNetworkRequest?.cancel()
    }
  }
  
}

extension Networking: Endpoints {
  func copy() -> Networking {
    return Self()
  }
  
  mutating func getRepos(user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
    cancelCurrentRequest()
    var searchComponent = GithubEndpoints.urlComp
    searchComponent.path = GithubEndpoints.getRepos(user)
    
    let task = genericURLSession(urlComponent: searchComponent, completion: completion)
    currentNetworkRequest = task
    
  }
  
  mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
    cancelCurrentRequest()
    var searchComponent = GithubEndpoints.urlComp
    searchComponent.path = GithubEndpoints.searchUser
    let query = "q=\"\(query)\"&page=\(String(page))"
    searchComponent.query = query
    
    currentNetworkRequest = genericURLSession(urlComponent: searchComponent, completion: completion)
  }
  
  mutating func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) {
    cancelCurrentRequest()
    let urlComponents = URLComponents(string: url.absoluteString)!
    genericURLSession(urlComponent: urlComponents) { (data) -> UIImage? in
      return UIImage(data: data)
    } completion: { completion($0) }
    
  }
}

struct NetworkingMock: Endpoints {
  
  func copy() -> NetworkingMock {
    return Self()
  }
  
  mutating func getRepos(user: String, completion: @escaping (Result<[Repository], NetworkingError>) -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.0001) {
      let repos: [Repository] = [
        Repository(name: "Repo1"),
        Repository(name: "Repo2"),
        Repository(name: "Repo3")
      ]
      completion(.success(repos))
    }
  }
  mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.0001) {
      let model = GithubModel(
        totalCount: 3,
        incompleteResults: false,
        items: [
          GithubUser(login: "Viranchee"),
          GithubUser(login: "virancheewednesday"),
          GithubUser(login: "rameez")
        ]
      )
      completion(.success(model))
    }
  }
  
  mutating func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.0001) {
      
      completion(.failure(.noDataError))
    }
  }
  
}
