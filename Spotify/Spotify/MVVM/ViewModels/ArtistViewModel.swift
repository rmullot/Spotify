//
//  ArtistViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

final class ArtistViewModel {

  private var artist: Artist?

  var name: String {
    return artist?.name ?? ""
  }

  var genres: String {
    return artist?.genres.joined(separator: ", ") ?? ""
  }

  func getImageURL(width: Int) -> String {
    guard let images = self.artist?.images, images.isNotEmpty else { return "" }
    return Image.getBestPicture(images: images, width: width)
  }

  private init() { }

  init(artist: Artist) {
    self.artist = artist
  }

  func isValidSearch(_ text: String) -> Bool {
    if text.isEmpty {
      return true
    } else {
      return text.isAlphaNumeric
    }
  }
}
