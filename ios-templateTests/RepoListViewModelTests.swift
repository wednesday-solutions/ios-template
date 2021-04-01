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
    let viewModel = RepoListViewModel(user: "Viranchee", networking: Networking())
    
    XCTAssert(viewModel.repositories.count == 0)
    viewModel.onDataLoad = { () -> Void in
      expectation.fulfill()
    }
    
    viewModel.searchForUserRepositories()
    wait(for: [expectation], timeout: 2)
    XCTAssert(viewModel.repositories.count > 1)
    
    let reposCount = viewModel.repositories.count
    
    viewModel.endOfPageReached()
    wait(for: [expectation], timeout: 2)
    XCTAssert(viewModel.repositories.count > reposCount)

  }
  
  func testLoadingMoreRepos() {
    let expectation = XCTestExpectation()
    let viewModel = RepoListViewModel(user: "Viranchee", networking: Networking())
    
    XCTAssert(viewModel.repositories.count == 0)
    viewModel.onDataLoad = { () -> Void in
      expectation.fulfill()
    }
    
    viewModel.searchForUserRepositories()
    wait(for: [], timeout: 2)
    let reposCount = viewModel.repositories.count
    
    viewModel.endOfPageReached()
    wait(for: [expectation], timeout: 2)
    XCTAssert(viewModel.repositories.count > reposCount)

  }
}
