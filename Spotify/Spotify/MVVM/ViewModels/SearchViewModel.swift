//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import SpotifyCore

class SearchViewModel {

  var propertyChanged:((_ key: String) -> Void)?

  enum PropertyKeys: String {
    case statusMessage
  }

  private var artists: [Artist]?
  private var searchKeyWord: String = ""

  private(set)var statusMessage: String = "" {
    didSet {
      propertyChanged?(PropertyKeys.statusMessage.rawValue)
    }
  }

  var artistsDidChange: ((SearchViewModel) -> Void)?

  var artistsCount: Int {
    return artists?.count ?? 0
  }

  var noResults: Bool {
    return artists?.isEmpty ?? true
  }

  func getArtistsInformations(searchKeyWord: String) {
//    if self.searchKeyWord != searchKeyWord {
      self.artists = nil
      self.searchKeyWord = searchKeyWord

      WebServiceService.sharedInstance.getArtistsList(artistName: searchKeyWord) { (result) in
        switch result {
        case .success(let artists):
          self.artists = artists
          self.artistsDidChange?(self)
        case .error(let message):
          self.statusMessage = message
        }
//      }
    }

  }

  func getArtistViewModel(index: Int) -> ArtistViewModel? {
    guard let artists = artists, artists.isNotEmpty, index < artists.count, index >= 0   else { return nil }
    return ArtistViewModel(artist: artists[index])
  }

  func rebootStatusMessage() {
    statusMessage = "No results available"
  }

  func isValidSearch(_ text: String) -> Bool {
    if text.isEmpty {
      return true
    } else {
      return text.isAlphaNumeric
    }
  }
}
