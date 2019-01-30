//
//  SpotifyUITests.swift
//  SpotifyUITests
//
//  Created by Romain Mullot on 24/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import XCTest

class SpotifyUITests: XCTestCase {

  private var app: XCUIApplication!

  override func setUp() {

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test.
    // Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()

    // In UI tests it’s important to set the initial state - such as interface orientation
    // - required for your tests before they run. The setUp method is a good place to do this.
    XCUIApplication.accessibilityActivate()

    app = XCUIApplication()
    // To fire addUIInterruptionMonitor

  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_search_and_display_Artists_Description_event() {
    let tableView = app.tables.firstMatch

    let searchBar = app.otherElements[UITestingIdentifiers.searchBarSpotify.rawValue]
    XCTAssertTrue(searchBar.exists)

    searchBar.tap()

    searchBar.typeText("ACDC")
    app.buttons["Search"].tap()
    let exists = NSPredicate(format: "self.count > 0")
    expectation (for: exists, evaluatedWith: tableView.cells, handler: nil)
    waitForExpectations(timeout: 8, handler: { (_) in

    })
    tableView.cells.element(boundBy: 0).tap()
    let descriptionView = self.app.collectionViews[UITestingIdentifiers.descriptionViewController.rawValue]

    XCTAssertTrue(descriptionView.exists)
  }
}
