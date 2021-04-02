//
//  HomeViewModelTests.swift
//  iOS-Template
//
//  Created by Viranchee on 31/03/21.
//

import XCTest
@testable import iOS_Template

class HomeViewModelTests: XCTestCase {
  let timeInterval: TimeInterval = 1
  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testSearchingUser() {
    let expectation = XCTestExpectation()
    let viewModel = HomeViewModel(networking: NetworkingMock())
    
    XCTAssert(viewModel.model.count == 0)
    viewModel.searchStringChanged(newString: "Viranchee") { (result) in
      switch result {
      case .success(let model):
        expectation.fulfill()
        XCTAssert(model.items.count > 1)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    wait(for: [expectation], timeout: timeInterval)
    XCTAssert(viewModel.model.count >= 1)

  }
  
  func testSearchingUserModifiedString() {
    let expectation = XCTestExpectation()
    let viewModel = HomeViewModel(networking: NetworkingMock())
    
    viewModel.searchStringChanged(newString: "Vir") { _ in }
    viewModel.searchStringChanged(newString: "Viranchee") { (result) in
      switch result {
      case .success(let model):
        expectation.fulfill()
        XCTAssert(model.items.count > 1)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    
    wait(for: [expectation], timeout: timeInterval)
    XCTAssert(viewModel.model.count >= 1)

  }
  
}
