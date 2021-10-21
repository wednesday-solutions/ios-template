//
//  ITunesEndpointTests.swift
//  TemplateTests
//
//  Created by Rameez Khan on 17/10/21.
//

import XCTest

class ITunesEndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCorrectUrlIsGenerated() {
        let searchEndpoint = ITunesEndpoint.getSong(searchText: "test")
        XCTAssertEqual(searchEndpoint.scheme, "https")
        XCTAssertEqual(searchEndpoint.baseURL, "itunes.apple.com")
        XCTAssertEqual(searchEndpoint.path, "/search")
        XCTAssertTrue(searchEndpoint.params.contains(URLQueryItem(name: "term", value: "test")))
        XCTAssertEqual(searchEndpoint.method, "get")
    }

}
