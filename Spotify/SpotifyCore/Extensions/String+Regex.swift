//
//  String+Regex.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

extension String {

  public var isAlphaNumeric: Bool {
    return range(of: "[^a-zA-ZÀ-ÿ0-9\\s]", options: .regularExpression) == nil
  }

}
