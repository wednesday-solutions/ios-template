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
    let viewModel = HomeViewModel()

    XCTAssert(viewModel.model.count == 0)
    viewModel.onDataLoad = { () -> Void in
      expectation.fulfill()
    }
    viewModel.searchStringChanged(newString: "Viranchee")
    
    wait(for: [expectation], timeout: 2)
    
    XCTAssert(viewModel.model.count > 1)

  }
  
  func testSearchingUserModifiedString() {
    let expectation = XCTestExpectation()
    let viewModel = HomeViewModel()
    
    XCTAssert(viewModel.model.count == 0)
    viewModel.onDataLoad = { () -> Void in
      expectation.fulfill()
    }
    
    viewModel.searchStringChanged(newString: "Viranchee")
    
    viewModel.searchStringChanged(newString: "V")
    wait(for: [expectation], timeout: 2)
    XCTAssert(viewModel.model.count > 3)

  }
  
  
}
