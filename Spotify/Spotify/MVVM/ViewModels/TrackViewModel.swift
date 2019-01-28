//
//  TrackViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

final class TrackViewModel: BaseViewModel {

  private var track: Track?

  var name: String {
    return track?.name ?? ""
  }

  internal required init() { }

  init(track: Track) {
    self.track = track
  }
}
