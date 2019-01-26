//
//  Artist.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 24/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public struct Artist: Codable {
  var idArtist: String = ""
  var name: String = ""
  var images: [Image] = []
  var genres: [String] = []

  enum CodingKeys: String, CodingKey {
    case idArtist = "id"
    case name = "name"
    case images = "images"
    case genres = "genres"
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    idArtist = try values.decode(String.self, forKey: .idArtist)
    images = try values.decode([Image].self, forKey: .images)
    name = try values.decode(String.self, forKey: .name)
    genres = try values.decode([String].self, forKey: .genres)
  }

}
