//
//  Networking.swift
//  ios-template
//
//  Created by Viranchee on 15/03/21.
//

import UIKit

struct Networking {
  
  private var currentNetworkRequest: URLSessionDataTask?
  
  init() {
    currentNetworkRequest = nil
  }
  
  @discardableResult
  private func genericURLSession<A>(url: URL?, decoder: @escaping (Data) -> A?, completion: @escaping (Result<A, NetworkingError>) -> Void) -> URLSessionDataTask? {
    guard let url = url else {
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
  
  private func genericURLSession<A: Decodable>(url: URL?, completion: @escaping (Result<A, NetworkingError>) -> Void) -> URLSessionDataTask? {
    let dataTask = genericURLSession(url: url) { (data) -> A? in
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
    let searchURL = GithubEndpoints.getRepos(user)
    let task = genericURLSession(url: searchURL, completion: completion)
    currentNetworkRequest = task
    
  }
  
  mutating func searchUsers(query: String, page: Int, completion: @escaping (Result<GithubModel, NetworkingError>) -> Void) {
    cancelCurrentRequest()
    let searchComponent = GithubEndpoints.searchUser(query, page)
    currentNetworkRequest = genericURLSession(url: searchComponent, completion: completion)
  }
  
  mutating func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) {
    cancelCurrentRequest()
    genericURLSession(url: url) { (data) -> UIImage? in
      return UIImage(data: data)
    } completion: { completion($0) }
    
  }
}
