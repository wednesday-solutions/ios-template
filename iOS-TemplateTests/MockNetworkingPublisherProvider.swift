//
//  MockNetworkingPublisherProvider.swift
//  iOS-TemplateTests
//
//  Created by apple on 01/06/21.
//

import Combine
import Foundation
@testable import iOS_Template

struct MockNetworkingPublisherProvider: NetworkingPublisherProviding {
  
  private let data: Data
  private let response: URLResponse
  
  private var publisher: AnyPublisher<(data: Data, response: URLResponse), URLError> {
    .just((data, response))
  }
  
  init(data: Data, response: HTTPURLResponse) {
    self.data = data
    self.response = response
  }
  
  func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    publisher
  }
  
  func publisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
    publisher
  }
  
}
