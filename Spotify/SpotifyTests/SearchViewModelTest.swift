//
//  SearchViewModelTest.swift
//  SpotifyTests
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import XCTest
import SpotifyCore
@testable import Spotify

class SearchViewModelTest: XCTestCase {

  private var viewModelValid = SearchViewModel()

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.

  }

  func test_default_errorMessage() {
    XCTAssertEqual(viewModelValid.errorMessage, "")
  }

  func test_NoResult_errorMessage() {
    viewModelValid.rebootStatusMessage()
    XCTAssertEqual(viewModelValid.errorMessage, L10n.noResults)
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

}
