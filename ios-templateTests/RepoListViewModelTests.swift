//
//  RepoListModelTests.swift
//  iOS-Template
//
//  Created by Viranchee on 31/03/21.
//

import XCTest
@testable import iOS_Template

class RepoListModelTests: XCTestCase {
  let timeout: TimeInterval = 1
  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testSearchingUserRepositories() {
    let expectation = XCTestExpectation()
    let viewModel = RepoListViewModel(user: "Viranchee", networking: NetworkingMock())

    XCTAssertEqual(viewModel.repositories.count, 0)
    viewModel.searchForUserRepositories { (result) in
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: timeout)
    XCTAssertGreaterThanOrEqual(viewModel.repositories.count, 1)

  }

}
