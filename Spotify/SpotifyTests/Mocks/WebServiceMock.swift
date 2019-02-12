//
//  WebServiceMock.swift
//  SpotifyTests
//
//  Created by Romain Mullot on 28/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import SpotifyCore

final class WebServiceMock: WebServiceProtocol {

  var isTokenValid: Bool = true

  func getAuth(completionHandler: @escaping (Result<SpotifyAuth>) -> Void) {
    let auth = SpotifyAuth()
    completionHandler(.success(auth))
  }

  func getArtistsList(artistName: String, completionHandler: @escaping (Result<[Artist]>) -> Void) {
    guard isTokenValid else {
      completionHandler(.error("no token"))
      return
    }
    let artists = [Artist()]
    completionHandler(.success(artists))
  }

  func getAlbumsList(idArtist: String, completionHandler: @escaping (Result<[Album]>) -> Void) {
    let albums = [Album()]
    completionHandler(.success(albums))
  }

  func getTopTrackList(idArtist: String, completionHandler: @escaping (Result<[Track]>) -> Void) {
    let tracks = [Track()]
    completionHandler(.success(tracks))
  }

  func cancelRequests() {

  }

}
