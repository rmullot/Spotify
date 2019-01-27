//
//  ParsingStructs.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 25/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public struct SearchArtistsRoot: Codable {
  var artists: SearchArtists

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    artists = try values.decode(SearchArtists.self, forKey: .artists)
  }
}

public struct SearchArtists: Codable {
  var href: String = ""
  var items: [Artist] = []

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    href = try values.decode(String.self, forKey: .href)
    items = try values.decode([Artist].self, forKey: .items)
  }
}

public struct SearchTracksRoot: Codable {
  var tracks: [Track] = []

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    tracks = try values.decode([Track].self, forKey: .tracks)
  }
}

public struct SearchAlbumsRoot: Codable {
  var href: String = ""
  var items: [Album] = []

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    href = try values.decode(String.self, forKey: .href)
    items = try values.decode([Album].self, forKey: .items)
  }
}

public struct SpotifyErrorRoot: Codable {
  var error: SpotifyError

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    error = try values.decode(SpotifyError.self, forKey: .error)
  }
}

public struct SpotifyError: Codable {
  var status: Int = 0
  var message: String = ""

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    status = try values.decode(Int.self, forKey: .status)
    message = try values.decode(String.self, forKey: .message)
  }
}
