//
//  TopTracksViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

final class TopTracksViewModel: BaseViewModel {

  private var tracks: [Track]?

  internal required init() { }

  var topTracksDidChange: ((TopTracksViewModel, Float) -> Void)?

  init(tracks: [Track]) {
    self.tracks = tracks
  }

  var tracksCount: Int {
    return tracks?.count ?? 0
  }

  var noResults: Bool {
    return tracks?.isEmpty ?? true
  }

  func getTrackViewModel(index: Int) -> TrackViewModel? {
    guard let tracks = tracks, tracks.isValidIndex(index) else { return nil }
    return TrackViewModel(track: tracks[index])
  }

  func updateTopTracks(heightTopTracks: Float) {
    self.topTracksDidChange?(self, heightTopTracks)
  }
}
