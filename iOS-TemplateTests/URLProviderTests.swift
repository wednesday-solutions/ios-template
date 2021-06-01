//
//  URLProviderTests.swift
//  iOS-TemplateTests
//
//  Created by apple on 01/06/21.
//

import XCTest
@testable import iOS_Template

class URLProviderTests: XCTestCase {
  
  private var urlProvider: URLProvider!
  
  override func setUpWithError() throws {
    urlProvider = .init()
  }
  
  override func tearDownWithError() throws {
    urlProvider = nil
  }
  
  func testUserURL() throws {
    let query = "asdf"
    let page = 1
    let url = try XCTUnwrap(urlProvider.makeSearchURL(query: query, page: page))
    let urlString = try XCTUnwrap(url.absoluteString)
    XCTAssertEqual(urlString, "https://api.github.com/search/users?q=%22\(query)%22&page=\(page)")
  }
  
  func testRepositoriesURL() throws {
    let user = GithubUser(login: "asdf", id: 0)
    let url = try XCTUnwrap(urlProvider.makeReposURL(for: user))
    let urlString = try XCTUnwrap(url.absoluteString)
    XCTAssertEqual(urlString, "https://api.github.com/users/\(user.login)/repos")
  }
  
}
