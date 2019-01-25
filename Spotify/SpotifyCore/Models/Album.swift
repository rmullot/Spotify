//
//  Album.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 24/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public struct Album: Codable {
  var idAlbum: String = ""
  var name: String = ""
  var images: [Image] = []
  
  enum CodingKeys: String, CodingKey {
    case idAlbum = "id"
    case name = "name"
    case images = "images"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    idAlbum = try values.decode(String.self, forKey: .idAlbum)
    images = try values.decode([Image].self, forKey: .images)
    name = try values.decode(String.self, forKey: .name)
  }
  
}
