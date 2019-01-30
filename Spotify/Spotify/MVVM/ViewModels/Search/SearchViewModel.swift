//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore
import SpotifyUI

final class SearchViewModel: BaseViewModel {

  enum PropertyKeys: String {
    case errorMessage
  }

  private var artists: [Artist]?

  var artistsDidChange: ((SearchViewModel) -> Void)?

  var artistsCount: Int {
    return artists?.count ?? 0
  }

  var noResults: Bool {
    return artists?.isEmpty ?? true
  }

  func getArtistsInformations(searchKeyWord: String) {
    self.artists = nil
    webServiceService.getArtistsList(artistName: searchKeyWord) { (result) in
      switch result {
      case .success(let artists):
        self.artists = artists
        self.artistsDidChange?(self)
      case .error(let message):
        self.errorMessage = message
        self.artists = []
        self.artistsDidChange?(self)
      }
    }

  }

  func displayDescription(index: Int) {
    guard let artists = artists, artists.isValidIndex(index) else { return }
    navigationService.navigateToDescription(artist: artists[index])
  }

  func getArtistViewModel(index: Int) -> ArtistViewModel? {
    guard let artists = artists, artists.isValidIndex(index) else { return nil }
    return ArtistViewModel(artist: artists[index])
  }

  func rebootStatusMessage() {
    errorMessage = L10n.noResults
  }

  func isValidSearch(_ text: String) -> Bool {
    if text.isEmpty {
      return true
    } else {
      return text.isAlphaNumeric
    }
  }
}
