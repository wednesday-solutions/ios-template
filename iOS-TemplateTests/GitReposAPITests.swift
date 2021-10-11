//
//  GitReposAPITests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 11/10/21.
//

import XCTest
@testable import iOS_Template

class GitReposAPITests: XCTestCase {
    let timeInterval: TimeInterval = 2
        
    func testGitReposForUserURLGeneration() {
        let api = GitReposAPI()
        let endpoint = api.generateURL(for:"Vir")
        XCTAssertNotNil(endpoint)
        XCTAssertEqual(endpoint!.path, "/users/Vir/repos")
        XCTAssertEqual(endpoint!.absoluteString, "https://api.github.com/users/Vir/repos")
    }

    func testSearchRepos() {
      let expectation = XCTestExpectation()
      var networking = GitReposMockAPI()
        networking.getRepos(of: "Viranchee") { (result) in
        switch result {
        case .success(let repos):
          expectation.fulfill()
            XCTAssertGreaterThanOrEqual(repos.count, 1)
        case .failure(let error):
          XCTFail(error.localizedDescription)
        }
      }
      wait(for: [expectation], timeout: timeInterval)
    }
}
