//
//  String+Spotify.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 25/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

extension String {

  func fromBase64() -> String {
    guard let data = Data(base64Encoded: self), let result = String(data: data, encoding: .utf8) else {
      return ""
    }
    return result
  }

  func toBase64() -> String {
    return Data(self.utf8).base64EncodedString()
  }

  /// Return a boolean checking if the string is not empty
  public var isNotEmpty: Bool {
    return !self.isEmpty
  }

  func urlEncoded() -> String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
  }
}
