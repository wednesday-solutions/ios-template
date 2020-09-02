//
//  BankShiftTests.swift
//  BankShiftTests
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import XCTest
import UIKit
import Apollo
@testable import BankShift

class BankShiftTests: XCTestCase {

    let loginVm = LoginViewModel.init()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginViewModel() throws {
        let responseString =
        """
        {
            "data": {
                "logIn": {
                    "__typename": "logIn",
                    "customer": {
                        "__typename": "Customer",
                        "username": "Test",
                        "name": "Test",
                        "dateCreated": "2020-08-31T05:10:53.303Z",
                        "currentPets": [],
                        "checkoutHistory": []
                    },
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IlRlc3QiLCJpYXQiOjE1OTg5NDY4NjV9.isPyHYOUKEJVfo1UghSQDZDqmB2nqTH896-dQUYVncg"
                }
            }
        }
        """

        guard let data = responseString.data(using: .utf8), let obj = try? JSONSerialization.jsonObject(with: data,
                                                                                                         options: []) as? JSONObject else { return XCTFail("Failed to convert object to jsonObject") }

        withCache(initialRecords: [:]) { cache in

            let store = ApolloStore(cache: cache)
            let client = ApolloClient(networkTransport: MockNetworkTransport(body: obj),
                                      store: store)

            let expectation = self.expectation(description: "Fetching query")
            client.perform(mutation: LoginRequestMutation.init(username: "test", password: "test")) { result in
                switch result {
                case let .failure(error):
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                    return
                case .success:
                    guard let data = try? result.get().data else { return }
                    let user =  self.loginVm.initWithLoginMutuation(data)
                    XCTAssert(user?.name == "Test", "Test finish")
                    expectation.fulfill()
                }

            }
            self.waitForExpectations(timeout: 5, handler: nil)

        }
    }

    func testRegisterViewModel() throws {
    }

}

extension XCTestCase {
    func withCache(initialRecords: RecordSet? = nil,
                   execute test: (NormalizedCache) throws -> Void) rethrows {

        return try InMemoryTestCacheProvider.withCache(initialRecords: initialRecords,
                                                       execute: test)
    }
}

protocol TestCacheProvider: AnyObject {
    static func withCache(initialRecords: RecordSet?,
                          execute test: (NormalizedCache) throws -> Void) rethrows
}

final class InMemoryTestCacheProvider: TestCacheProvider {
    /// Execute a test block rather than return a cache synchronously, since cache setup may be
    /// asynchronous at some point.
    static func withCache(initialRecords: RecordSet? = nil,
                          execute test: (NormalizedCache) throws -> Void) rethrows {
        let cache = InMemoryNormalizedCache(records: initialRecords ?? [:])
        try test(cache)
    }
}
