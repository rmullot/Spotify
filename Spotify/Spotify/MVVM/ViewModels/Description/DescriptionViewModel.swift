//
//  DescriptionViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

final class DescriptionViewModel {

  private var artist: Artist?
  private var topTracks: [Track]?
  private var albums: [Album]?

  var albumsDidChange: ((DescriptionViewModel) -> Void)?
  var topTrackDidChange: ((DescriptionViewModel, Float) -> Void)?

  private init() { }

  init(artist: Artist) {
    self.artist = artist
  }

  func getArtistViewModel() -> ArtistViewModel? {
    guard let artist = artist else { return nil }
    return ArtistViewModel(artist: artist)
  }

  func getTopTracksViewModel() -> TopTracksViewModel {
    guard let topTracks = topTracks, topTracks.isNotEmpty else { return TopTracksViewModel(tracks: []) }
    return TopTracksViewModel(tracks: topTracks)
  }

  func getAlbumsViewModel() -> AlbumsViewModel {
    guard let albums = albums, albums.isNotEmpty else { return AlbumsViewModel(albums: []) }
    return AlbumsViewModel(albums: albums)
  }

  //TODO: to check
  func updateTopTrackList(heightCardMenu: Float) {
    self.topTrackDidChange?(self, heightCardMenu)
  }

  func updateDescriptionContent() {
    guard let idArtist = artist?.idArtist, idArtist.isNotEmpty else { return }
    WebServiceService.sharedInstance.getTopTrackList(idArtist: idArtist) { (result) in
      switch result {
      case .success(let tracks):
        self.topTracks = tracks
        self.topTrackDidChange?(self, 0)
      case .error(let message):
        //TODO: to upgrade
        print(message)
      }
    }

    WebServiceService.sharedInstance.getAlbumsList(idArtist: idArtist) { (result) in
      switch result {
      case .success(let albums):
        self.albums = albums
        self.albumsDidChange?(self)
      case .error(let message):
        //TODO: to upgrade
        print(message)
      }
    }

  }
}
