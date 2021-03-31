//
//  RepoListModelTests.swift
//  iOS-Template
//
//  Created by Viranchee on 31/03/21.
//

import XCTest
@testable import iOS_Template

class RepoListModelTests: XCTestCase {
  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testSearchingUserRepositories() {
    let expectation = XCTestExpectation()
    let waiter = XCTWaiter()
    let viewModel = RepoListViewModel(user: "Viranchee")
    
    XCTAssert(viewModel.repositories.count == 0)
    viewModel.onDataLoad = { () -> Void in
      expectation.fulfill()
    }
    
    viewModel.searchForUserRepositories()
    waiter.wait(for: [expectation], timeout: 5)
    XCTAssert(viewModel.repositories.count > 1)
    
    let reposCount = viewModel.repositories.count
    
    viewModel.endOfPageReached()
    waiter.wait(for: [expectation], timeout: 5)
    XCTAssert(viewModel.repositories.count > reposCount)

  }
  
}
