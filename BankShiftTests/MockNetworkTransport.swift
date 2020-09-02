//
//  MockNetworkTransport.swift
//  BankShiftTests
//
//  Created by Parth on 01/09/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation
import Apollo

final class MockNetworkTransport: NetworkTransport {

    private final class MockTask: Cancellable {
        func cancel() { }
    }

    enum NetworkError: Error {
        case networkFailure
    }

    let simulateNetworkFailure: Bool

    let body: JSONObject

    init(body: JSONObject, simulateNetworkFailure: Bool = false) {
        self.body = body
        self.simulateNetworkFailure = simulateNetworkFailure

    }

    func send<Operation: GraphQLOperation>(operation: Operation, completionHandler: @escaping (_ result: Result<GraphQLResponse<Operation.Data>, Error>) -> Void) -> Cancellable {
        DispatchQueue.global(qos: .default).async {

            if self.simulateNetworkFailure {
                completionHandler(.failure(NetworkError.networkFailure))
                return
            }

            completionHandler(.success(GraphQLResponse(operation: operation,
            body: self.body)))
        }

        return MockTask()
    }
}
