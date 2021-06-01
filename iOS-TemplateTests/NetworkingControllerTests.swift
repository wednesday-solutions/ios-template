//
//  NetworkingControllerTests.swift
//  iOS-TemplateTests
//
//  Created by apple on 01/06/21.
//

import Combine
import XCTest
@testable import iOS_Template

class NetworkingControllerTests: XCTestCase {
  
  private var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    cancellables = []
  }
  
  override func tearDownWithError() throws {
    cancellables = nil
  }
  
  func testUsers() throws {
    let data = try XCTUnwrap(usersJSON.data(using: .utf8))
    let publisherProvider = MockNetworkingPublisherProvider(data: data, response: HTTPURLResponse())
    let networkingController = NetworkingController(publisherProvider: publisherProvider)
    
    let query = "user"
    let expectedCount = 3
    let description = "Expect \(expectedCount) users with \"\(query)\" in their usernames."
    let expectation = XCTestExpectation(description: description)
    
    networkingController
      .usersPublisher(query: query)
      .asResult()
      .sink { result in
        switch result {
        case .success(let users):
          XCTAssertEqual(users.count, expectedCount)
          XCTAssertTrue(users.allSatisfy { $0.login.contains(query) })
        case .failure(let error):
          XCTFail(error.localizedDescription)
        }
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 1.0)
  }
  
  func testRepositories() throws {
    let data = try XCTUnwrap(repositoriesJSON.data(using: .utf8))
    let publisherProvider = MockNetworkingPublisherProvider(data: data, response: HTTPURLResponse())
    let networkingController = NetworkingController(publisherProvider: publisherProvider)
    
    let username = "asdf"
    let expectedCount = 2
    let user = GithubUser(login: username, id: 1)
    let description = "Expect \(expectedCount) repositories for user \"\(username)\""
    let expectation = XCTestExpectation(description: description)
    
    networkingController
      .reposPublisher(for: user)
      .asResult()
      .sink { result in
        switch result {
        case .success(let repositories): XCTAssertEqual(repositories.count, expectedCount)
        case .failure(let error): XCTFail(error.localizedDescription)
        }
        expectation.fulfill()
      }
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 1.0)
  }
  
}

private let usersJSON = """
{
  "total_count": 3,
  "incomplete_results": false,
  "items": [
    {
      "login": "user123",
      "id": 123
    },
    {
      "login": "user456",
      "id": 456
    },
    {
      "login": "user789",
      "id": 789
    }
  ]
}
"""

private let repositoriesJSON = """
[
  {
    "name": "repo1",
    "id": 1
  },
  {
    "name": "repo2",
    "id": 2
  }
]
"""
