//
//  UserDefaultsServiceMock.swift
//  SpotifyTests
//
//  Created by Romain Mullot on 28/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import SpotifyCore

final class UserDefaultsServiceMock: UserDefaultsServiceProtocol {
  func getObject<T>() -> T? where T: Decodable, T: Encodable {
    return nil
  }

  func saveObject<T>(_ object: T) -> Bool where T: Decodable, T: Encodable {
    return false
  }

  func removeObject<T>(_ object: T) where T: Decodable, T: Encodable {

  }

}
