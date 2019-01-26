//
//  ArtistViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

class ArtistViewModel {

  private var artist: Artist?

  var name: String {
    return artist?.name ?? ""
  }

  var genres: String {
    return artist?.genres.joined(separator: ",") ?? ""
  }

  //TODO: to upgrade to take the good image
  var imageURL: String {
      guard let images = self.artist?.images, images.isNotEmpty else { return "" }
      return images[0].url
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
