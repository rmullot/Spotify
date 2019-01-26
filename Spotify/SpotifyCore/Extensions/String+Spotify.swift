//
//  String+Spotify.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 25/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

extension String {

  public func fromBase64() -> String {
    guard let data = Data(base64Encoded: self), let result = String(data: data, encoding: .utf8) else {
      return ""
    }
    return result
  }

  public func toBase64() -> String {
    return Data(self.utf8).base64EncodedString()
  }

  /// Return a boolean checking if the string is not empty
  public var isNotEmpty: Bool {
    return !self.isEmpty
  }

  public func isUrl(_ completionHandler: @escaping (Bool, URL?) -> Void ) {
    guard self.isNotEmpty, let url = URL(string: self) else {
      return completionHandler(false, nil)
    }
    return completionHandler(UIApplication.shared.canOpenURL(url), url)

  }

  public func urlEncoded() -> String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
  }
}
