//
//  HomeViewModelTests.swift
//  iOS-Template
//
//  Created by Viranchee on 31/03/21.
//

import XCTest
@testable import iOS_Template

class HomeViewModelTests: XCTestCase {
  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testSearchingUser() {
    let expectation = XCTestExpectation()
    let waiter = XCTWaiter()
    let viewModel = HomeViewModel()
    
    XCTAssert(viewModel.model.count == 0)
    viewModel.onDataLoad = { () -> Void in
      expectation.fulfill()
    }
    
    viewModel.searchStringChanged(newString: "Viranchee")
    waiter.wait(for: [expectation], timeout: 5)
    XCTAssert(viewModel.model.count > 1)
    
    viewModel.searchStringChanged(newString: "V")
    waiter.wait(for: [expectation], timeout: 5)
    XCTAssert(viewModel.model.count > 3)

  }
  
}
