//
//  GithubEndpointsTests.swift
//  iOS-TemplateTests
//
//  Created by Viranchee on 02/04/21.
//

import XCTest
@testable import iOS_Template

class GithubEndpointsTests: XCTestCase {
  func testUserSearchURL() {
    let endpoint = GithubEndpoints.searchUser("Vir", 1)
    XCTAssertNotNil(endpoint)
    XCTAssertEqual(endpoint!.path, "/search/users")
    XCTAssertEqual(endpoint!.absoluteString, "https://api.github.com/search/users?q=%22Vir%22&page=1")
  }
  
  func testRepoForUserURL() {
    let endpoint = GithubEndpoints.getRepos("Vir")
    XCTAssertNotNil(endpoint)
    XCTAssertEqual(endpoint!.path, "/users/Vir/repos")
    XCTAssertEqual(endpoint!.absoluteString, "https://api.github.com/users/Vir/repos")

  }
}
