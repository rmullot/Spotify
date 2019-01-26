//
//  Image.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 25/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public struct Image: Codable {
  public var height: Int = 0
  public var url: String = ""
  public var width: Int = 0

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    height = try values.decode(Int.self, forKey: .height)
    url = try values.decode(String.self, forKey: .url)
    width = try values.decode(Int.self, forKey: .width)
  }

}
