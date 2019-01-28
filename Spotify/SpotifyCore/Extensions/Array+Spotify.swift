//
//  Array+Spotify.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 25/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

extension Array {

  /// Return a boolean checking if the array is not empty
  public var isNotEmpty: Bool {
    return !self.isEmpty
  }

  public func isValidIndex(_ index: Int) -> Bool {
    guard self.isNotEmpty else { return false }
    return  index < self.count && index >= 0
  }

}
