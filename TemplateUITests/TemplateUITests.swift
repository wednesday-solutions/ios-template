//
//  TemplateUITests.swift
//  TemplateUITests
//
//  Created by Rameez Khan on 12/10/21.
//

import XCTest

class TemplateUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testIfTableViewIsLoaded() {        
        let app = XCUIApplication()
        app.launchArguments = ["-debugServer"]
        app.launch()
        let songsTableViewTable = app.tables["songs-table-view"]
        XCTAssertNotNil(songsTableViewTable)
    }
    
    func testAfterTextEnteredInSearchCancelButtonShown() {
        let app = XCUIApplication()
        app.launchArguments = ["-debugServer"]
        app.launch()
        
        let songsTableViewTable = app.tables["songs-table-view"]
        songsTableViewTable.swipeDown()
        app.searchFields.firstMatch.tap()
        
        app.searchFields.firstMatch.typeText("J")
        
        let cell = songsTableViewTable.cells.firstMatch.label
        XCTAssertGreaterThanOrEqual(songsTableViewTable.cells.count, 2)
    }
    
    func testAfterSearchClickingOnCellShouldNavigateToDetailView() {
        let app = XCUIApplication()
        app.launchArguments = ["-debugServer"]
        app.launch()
        
        let songsTableViewTable = app.tables["songs-table-view"]
        songsTableViewTable.swipeDown()
        app.searchFields.firstMatch.tap()
        
        app.searchFields.firstMatch.typeText("J")
        songsTableViewTable.cells.firstMatch.tap()
       
    }
}
