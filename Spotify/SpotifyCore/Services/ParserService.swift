//
//  ParserService.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 24/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation

public enum ParserResult<T> where T: Codable {
    case success(T?)
    case failure(Swift.Error, String)
}

public enum ParserError: Error {
    case decodeObject
    case spotifyError
    case unavailableAPI
    case unknownObject
}

public typealias ParserCallback<T> = (ParserResult<T>) -> Void where T: Codable

public protocol ParserServiceProtocol {
  associatedtype Element: Codable
  static func parse(_ json: Data, completionHandler: ParserCallback<Element>?)
}

public final class ParserService<T>: ParserServiceProtocol where T: Codable {

  private init() { }

  public static func parse(_ json: Data, completionHandler: ParserCallback<T>?) {
    do {
      let decodedObject = try JSONDecoder().decode(T.self, from: json)
      completionHandler?(ParserResult.success(decodedObject))

    } catch DecodingError.dataCorrupted(let context) {
      print(context)
      completionHandler?(ParserResult.failure(ParserError.decodeObject, context.debugDescription))
    } catch DecodingError.keyNotFound(let key, let context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      completionHandler?(ParserResult.failure(ParserError.decodeObject, context.debugDescription))
    } catch DecodingError.valueNotFound(let value, let context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      completionHandler?(ParserResult.failure(ParserError.decodeObject, context.debugDescription))
    } catch DecodingError.typeMismatch(let type, let context) {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
      do {
        let spotifyError = try JSONDecoder().decode(SpotifyErrorRoot.self, from: json)
        completionHandler?(ParserResult.failure(ParserError.spotifyError, spotifyError.error.message))
      } catch {
        print("error: ", error)
        completionHandler?(ParserResult.failure(ParserError.decodeObject, context.debugDescription))
      }
    } catch {
      print("error: ", error)
      completionHandler?(ParserResult.failure(ParserError.unknownObject, error.localizedDescription))
    }
  }
}
