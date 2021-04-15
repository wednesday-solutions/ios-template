//
//  HomeViewModelTests.swift
//  iOS-Template
//
//  Created by Viranchee on 31/03/21.
//

import XCTest
@testable import iOS_Template

class HomeViewModelTests: XCTestCase {
  let timeInterval: TimeInterval = 2
  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testSearchingUser() {
    let expectation = XCTestExpectation()
    let viewModel = HomeViewModel(networking: NetworkingMock())
    
    XCTAssertEqual(viewModel.model.count, 0)
    viewModel.searchStringChanged(newString: "Viranchee") { (result) in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeInterval)
    XCTAssertGreaterThanOrEqual(viewModel.model.count, 1)

  }
  
  func testSearchingUserModifiedString() {
    let expectation = XCTestExpectation()
    let viewModel = HomeViewModel(networking: NetworkingMock())
    
    viewModel.searchStringChanged(newString: "Vir") { _ in }
    viewModel.searchStringChanged(newString: "Viranchee") { (result) in
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: timeInterval)
    XCTAssertGreaterThanOrEqual(viewModel.model.count, 1)

  }
  
}
