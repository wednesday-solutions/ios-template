//
//  NetworkingPublisherProviding.swift
//  iOS-Template
//
//  Created by apple on 28/05/21.
//

import Combine
import Foundation

protocol NetworkingPublisherProviding {
  
  /// Provides a publisher that publishes data and a response successfully, or fails with a URL error for the given URL.
  /// - Parameter url: The URL for which to create a publisher.
  func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
  
  /// Provides a publisher that publishes data and a response successfully, or fails with a URL error for the given URL request.
  /// - Parameter url: The URL request for which to create a publisher.
  func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
  
}

extension URLSession: NetworkingPublisherProviding {
  
  /// Returns a publisher that wraps a URL session data task publisher for a given URL.
  /// - Parameter url: The URL for which to create a data task publisher.
  func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    dataTaskPublisher(for: url)
      .eraseToAnyPublisher()
  }
  
  /// Returns a publisher that wraps a URL session data task publisher for a given URL request.
  /// - Parameter url: The URL request for which to create a data task publisher.
  func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    dataTaskPublisher(for: request)
      .eraseToAnyPublisher()
  }
  
}
