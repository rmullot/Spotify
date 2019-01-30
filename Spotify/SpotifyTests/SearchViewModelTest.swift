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

class SearchViewModelTest: EnvironmentMock {

  private var viewModelValid = SearchViewModel()
  private var artistViewModel = ArtistViewModel()

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
//    viewModelValid.getArtistsInformations(searchKeyWord: "ACDC")
//    artistViewModel = viewModelValid.getArtistViewModel(index: 0)!

  }

  override func tearDown() {
    super.tearDown()
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_search_Valid() {
    webServiceService.isTokenValid = true
    viewModelValid.getArtistsInformations(searchKeyWord: "ACDC")
    XCTAssertEqual(viewModelValid.artistsCount, 1)
  }

  func test_search_Invalid() {
    webServiceService.isTokenValid = false
    viewModelValid.getArtistsInformations(searchKeyWord: "ACDC")
    XCTAssertEqual(viewModelValid.artistsCount, 0)
  }

  func test_default_errorMessage() {
    XCTAssertEqual(viewModelValid.errorMessage, "")
  }

  func test_NoResult_errorMessage() {
    viewModelValid.rebootStatusMessage()
    XCTAssertEqual(viewModelValid.errorMessage, L10n.noResults)
  }

  func test_isValidSearch_Valid() {
    XCTAssertTrue(viewModelValid.isValidSearch("ACDC"))
    XCTAssertTrue(viewModelValid.isValidSearch(""))
  }

  func test_isValidSearch_Invalid() {
    XCTAssertFalse(viewModelValid.isValidSearch("AC/DC"))
    XCTAssertFalse(viewModelValid.isValidSearch("@AC"))
  }

}
