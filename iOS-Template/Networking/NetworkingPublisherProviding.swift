//
//  NetworkingPublisherProviding.swift
//  iOS-Template
//
//  Created by apple on 28/05/21.
//

import Combine
import Foundation

protocol NetworkingPublisherProviding {
  
  func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
  
  func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
  
}

extension URLSession: NetworkingPublisherProviding {
  
  func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    dataTaskPublisher(for: url)
      .eraseToAnyPublisher()
  }
  
  func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    dataTaskPublisher(for: request)
      .eraseToAnyPublisher()
  }
  
}
