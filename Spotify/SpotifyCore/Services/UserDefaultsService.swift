//
//  UserDefaultsService.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 25/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public protocol UserDefaultsServiceProtocol {
  static func getObject<T: Codable>() -> T?
  static func saveObject<T>(_ object: T) -> Bool where T: Codable
  static func removeObject<T>(_ object: T) where T: Codable
}

public final class UserDefaultsService: UserDefaultsServiceProtocol {

  @discardableResult
  public static func saveObject<T>(_ object: T) -> Bool where T: Codable {
    let encoder = JSONEncoder()
    guard let encoded = try? encoder.encode(object) else { return false }
    UserDefaults.standard.set(encoded, forKey: String(describing: T.self))
    return true
  }

  public static func getObject<T: Codable>() -> T? {
    let decoder = JSONDecoder()
    guard let data = UserDefaults.standard.data(forKey: String(describing: T.self)), let codableObject = try? decoder.decode(T.self, from: data) else { return nil }
    return codableObject
  }

  public static func removeObject<T>(_ object: T) where T: Codable {
    UserDefaults.standard.removeObject(forKey: String(describing: object.self))
  }

  private init() {}
}
