//
//  ParsingStructs.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 25/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public struct ArtistListRoot: Decodable {
  var error: SpotifyError?
  var artistList: [Artist] = []

  //  public init(from decoder: Decoder) throws {
  //    let values = try decoder.container(keyedBy: CodingKeys.self)
  //    error = try values.decode(Int.self, forKey: .error)
  //    artistList = try values.decode(Int.self, forKey: .artistList)
  //  }
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

public struct SpotifyAuth: Codable {
  var accessToken: String = ""
  var tokenType: String = ""
  var expiresIn: Int = 0
  var scope: String = ""
  var obtainingDate: Date = Date()

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case expiresIn = "expires_in"
    case scope = "scope"
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try values.decode(String.self, forKey: .accessToken)
    tokenType = try values.decode(String.self, forKey: .tokenType)
    scope = try values.decode(String.self, forKey: .scope)
    expiresIn = try values.decode(Int.self, forKey: .expiresIn)
    obtainingDate = Date()
  }

  public var isValid: Bool {
    let timeinterval = obtainingDate.timeIntervalSinceNow - Double(expiresIn)
    guard accessToken.isNotEmpty &&  timeinterval <= 0 else {
      UserDefaultsService.removeObject(self)
      return false
    }
    return true
  }
}
