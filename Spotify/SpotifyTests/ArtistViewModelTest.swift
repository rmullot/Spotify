//
//  ArtistViewModelTest.swift
//  SpotifyTests
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import XCTest
import SpotifyCore
@testable import Spotify

class ArtistViewModelTest: EnvironmentMock {

  private var viewModelValid: ArtistViewModel!

  override func setUp() {
    super.setUp()
    var image1 = Image()
    image1.width = 64
    image1.height = 64
    image1.url = "https:www.google.com/imageURL.png"
    var image2 = Image()
    image2.width = 264
    image2.height = 264
    image2.url = "https:www.google.com/imageURL2.png"
    // Put setup code here. This method is called before the invocation of each test method in the class.
    var artistValid = Artist()
    artistValid.idArtist = "1234"
    artistValid.name = "Nicolas"
    artistValid.images = [image1, image2]
    artistValid.genres = ["rock", "jazz"]
    viewModelValid = ArtistViewModel(artist: artistValid)
  }

  override func tearDown() {
    super.tearDown()
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_name_description_Valid() {
    XCTAssertEqual(viewModelValid.name, "Nicolas")
  }

  func test_genres_description_Valid() {
    XCTAssertEqual(viewModelValid.genres, "rock, jazz")
  }

  func test_imageURL_Valid() {
    XCTAssertEqual(viewModelValid.getImageURL(width: 80), "https:www.google.com/imageURL.png")
  }

  func test_isValidSearch_Success() {
    XCTAssertTrue(viewModelValid.isValidSearch("acdc 80"))
  }

  func test_isValidSearch_Fail() {
    XCTAssertFalse(viewModelValid.isValidSearch("acdc@80"))
  }
}
