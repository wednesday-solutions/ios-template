//
//  GitUserAPITests.swift
//  iOS-TemplateTests
//
//  Created by Apple on 11/10/21.
//

import XCTest
@testable import iOS_Template

class GitUserAPITests: XCTestCase {
    let timeInterval: TimeInterval = 2
        
    func testGitHubUserURLGeneration() {
        let api = GitUsersAPI()
        let endpoint = api.generateURL(for: "Vir", page: 1)
        XCTAssertNotNil(endpoint)
        XCTAssertEqual(endpoint!.path, "/search/users")
        XCTAssertEqual(endpoint!.absoluteString, "https://api.github.com/search/users?q=%22Vir%22&page=1")
    }

    func testGitUserSearch() {
        let expectation = XCTestExpectation()
        var api = GitUsersMockAPI()
        api.searchUsers(query: "Vir", page: 1) { (result) in
            switch result {
            case .success(let model):
                expectation.fulfill()
                XCTAssertGreaterThanOrEqual(model.items.count, 1)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: timeInterval)
    }
}
