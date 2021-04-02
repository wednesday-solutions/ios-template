//
//  NetworkingMockTests.swift
//  iOS-TemplateTests
//
//  Created by Viranchee on 02/04/21.
//

import XCTest
@testable import iOS_Template

class NetworkingTests: XCTestCase {
  let timeInterval: TimeInterval = 1
  
  func testUserSearch() {
    let expectation = XCTestExpectation()
    var networking = NetworkingMock()
    networking.searchUsers(query: "Vir", page: 1) { (result) in
      switch result {
      case .success(let model):
        expectation.fulfill()
        XCTAssert(model.items.count > 1)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    
    wait(for: [expectation], timeout: timeInterval)
    
  }
  
  func testSearchRepos() {
    let expectation = XCTestExpectation()
    var networking = NetworkingMock()
    networking.searchUsers(query: "Viranchee", page: 1) { (result) in
      switch result {
      case .success(let repos):
        expectation.fulfill()
        XCTAssert(repos.items.count >= 1)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    
    wait(for: [expectation], timeout: timeInterval)
  }
}
