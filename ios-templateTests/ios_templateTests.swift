//
//  ios_templateTests.swift
//  ios-templateTests
//
//  Created by Viranchee on 15/03/21.
//

import XCTest
@testable import ios_template

class ios_templateTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  /// This test checks if github user Viranchee is searchable. It tests Networking logic as well
  /// - Throws: User "Viranchee" not found on github
  func testUserVirancheeIsThere() throws {
    let expectation = XCTestExpectation()
    let waiter = XCTWaiter()

    let userSearchViewModel = UserSearchViewModel(searchText: "viranchee")
    userSearchViewModel.searchUsers {
      expectation.fulfill()
    }

    waiter.wait(for: [expectation], timeout: 2)
    
    XCTAssert(userSearchViewModel.userList.contains { (user) -> Bool in
      return user.login == "Viranchee"
    })
  }
  
  /// This test checks if github user Viranchee is searchable. It tests Networking logic as well
  /// - Throws: User "Viranchee" not found on github
  func testRandomUserDoesNotExist() throws {
    let expectation = XCTestExpectation()
    let waiter = XCTWaiter()

    let userSearchViewModel = UserSearchViewModel(searchText: "wjefisdlkjavjdvnsdvjsiojvlkvaorgjskvasv")
    userSearchViewModel.searchUsers {
      expectation.fulfill()
    }

    waiter.wait(for: [expectation], timeout: 2)
    XCTAssert(userSearchViewModel.userList.count == 0)
  }
  
  func testRepoListViewModelForUserViranchee() {
    let expectation = XCTestExpectation()
    let waiter = XCTWaiter()

    let repoListViewModel = RepoListViewModel(user: "Viranchee")
    repoListViewModel.getRepos {
      expectation.fulfill()
    }

    waiter.wait(for: [expectation], timeout: 2)
    dump(repoListViewModel.repositories)
    XCTAssert(repoListViewModel.repositories.contains(where: { (repo) -> Bool in
      repo.name == "Resume"
    }))
  }
  
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
