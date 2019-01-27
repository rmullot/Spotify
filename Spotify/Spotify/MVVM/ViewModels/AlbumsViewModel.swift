//
//  AlbumsViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

final class AlbumsViewModel: BaseViewModel {

  private var albums: [Album]?

  internal required init() { }

  init(albums: [Album]) {
    self.albums = albums
  }

  var albumsCount: Int {
    return albums?.count ?? 0
  }

  func getAlbumViewModel(index: Int) -> AlbumViewModel? {
    guard let albums = albums, albums.isValidIndex(index) else { return nil }
    return AlbumViewModel(album: albums[index])
  }
}
