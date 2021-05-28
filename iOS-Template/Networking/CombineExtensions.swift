//
//  CombineExtensions.swift
//  iOS-Template
//
//  Created by apple on 28/05/21.
//

import Combine
import Foundation

extension Publisher {
  
  /// Transforms values or errors from upstream into a `Result`.
  /// - Returns: A publisher that publishes a Result with success if upstream sent a value or a failure
  ///   if upstream sent an error and completes when upstream completes.
  func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
    self
      .flatMap { Just(.success($0)) }
      .catch { Just(.failure($0)) }
      .eraseToAnyPublisher()
  }
  
}

extension AnyPublisher {
  
  /// Converts the provided value into a constant value publisher.
  static func just(_ value: Output, failureType: Failure.Type = Failure.self) -> Self {
    Just(value)
      .setFailureType(to: Failure.self)
      .eraseToAnyPublisher()
  }
  
  /// Converts the provided error into a constant error publisher.
  static func fail(outputType: Output.Type = Output.self, _ error: Failure) -> Self {
    Fail(outputType: Output.self, failure: error)
      .eraseToAnyPublisher()
  }
  
}

extension Error {
  
  /// Converts the receiver error into a constant error publisher.
  func publisher<Output>(outputType: Output.Type = Output.self) -> AnyPublisher<Output, Self> {
    return .fail(self)
  }

}
