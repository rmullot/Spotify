//
//  Track.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 24/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public struct Track: Codable {
  public var idTrack: String = ""
  public var name: String = ""

  enum CodingKeys: String, CodingKey {
    case idTrack = "id"
    case name = "name"
  }

  public init() { }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    idTrack = try values.decode(String.self, forKey: .idTrack)
    name = try values.decode(String.self, forKey: .name)
  }

}
