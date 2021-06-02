//
//  NetworkingController.swift
//  Pods
//
//  Created by apple on 28/05/21.
//

import Combine
import Foundation

struct NetworkingController {
  
  private let publisherProvider: NetworkingPublisherProviding
  private let urlProvider: URLProvider
  
  init(
    publisherProvider: NetworkingPublisherProviding = URLSession.shared,
    urlProvider: URLProvider = URLProvider()
  ) {
    self.publisherProvider = publisherProvider
    self.urlProvider = urlProvider
  }
  
  /// Returns a publisher that on success publishes an array of users matching the search result and the page number
  /// provided, or fails with any networking error from upstream.
  /// - Parameters:
  ///   - query: The string to search for
  ///   - page: The page number of search results. Defaults to 1.
  func usersPublisher(query: String, page: Int = 1) -> AnyPublisher<[GithubUser], NetworkingError> {
    guard let url = urlProvider.makeSearchURL(query: query, page: page) else {
      return .fail(NetworkingError(urlErrorCode: .badURL))
    }
    return publisherProvider
      .publisher(for: url)
      .map(\.data)
      .catch { AnyPublisher.fail(NetworkingError(urlError: $0)) }
      .decode(type: GithubModel.self, decoder: JSONDecoder())
      .catch { _ in AnyPublisher.fail(NetworkingError.jsonDecodingError) }
      .map(\.items)
      .eraseToAnyPublisher()
  }
  
  /// Returns a publisher that on success publishes an array of repositories belonging to the provided user, or fails
  /// with any networking error from upstream.
  /// - Parameters:
  ///   - query: The string to search for
  ///   - page: The page number of search results. Defaults to 1.
  func reposPublisher(for user: GithubUser) -> AnyPublisher<[Repository], NetworkingError> {
    guard let url = urlProvider.makeReposURL(for: user) else {
      return .fail(NetworkingError(urlErrorCode: .badURL))
    }
    return publisherProvider
      .publisher(for: url)
      .map(\.data)
      .catch { AnyPublisher.fail(NetworkingError(urlError: $0)) }
      .decode(type: [Repository].self, decoder: JSONDecoder())
      .catch { _ in AnyPublisher.fail(NetworkingError.jsonDecodingError) }
      .eraseToAnyPublisher()
  }
  
}
