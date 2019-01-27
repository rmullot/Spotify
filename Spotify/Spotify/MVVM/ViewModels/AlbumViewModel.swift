//
//  AlbumViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

final class AlbumViewModel {

  private var album: Album?

  var name: String {
    return album?.name ?? ""
  }

  func getImageURL(width: Int) -> String {
    guard let images = self.album?.images, images.isNotEmpty else { return "" }
    return Image.getBestPicture(images: images, width: width)
  }

  private init() { }

  init(album: Album) {
    self.album = album
  }
}
