//
//  RepoListModelTests.swift
//  iOS-Template
//
//  Created by Viranchee on 31/03/21.
//

import XCTest
@testable import iOS_Template

class RepoListModelTests: XCTestCase {
    let timeout: TimeInterval = 2
    
    func testSearchingUserRepositories() {
        let expectation = XCTestExpectation()
        let viewModel = RepoListViewModel(user: "Viranchee")
        viewModel.gitReposAPI = GitReposMockAPI()
        XCTAssertEqual(viewModel.repositories.count, 0)
        viewModel.searchForUserRepositories { (result) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
        XCTAssertGreaterThanOrEqual(viewModel.repositories.count, 1)
    }
}
