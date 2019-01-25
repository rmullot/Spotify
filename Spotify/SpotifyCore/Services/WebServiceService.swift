//
//  WebServiceService.swift
//  SpotifyCore
//
//  Created by Romain Mullot on 24/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit
import SwiftMessages

public enum Result<T> {
  case success(T)
  case error(String)
}

private enum TypeWebService {
  case authentification
  case searchArtists
}

public protocol WebServiceServiceProtocol {
  var isTokenValid: Bool { get }
  func getAuth(completionHandler:@escaping (Result<SpotifyAuth>) -> Void)
  func cancelRequests()
}

public final class WebServiceService: WebServiceServiceProtocol {

  public var onlineMode: OnlineMode = .online
  public static let sharedInstance = WebServiceService()

  private enum SpotifyKeys: String {
    case uri = "https://api.spotify.com/v1/"
    case authURL = "https://accounts.spotify.com/api/token"
    case clientID = "62965bb37d4e4733aaf9115e0775d64c"
    case secret = "7a3b7af6325e495f93698996fd6bbf6a"
  }

  private var spotifyAuth: SpotifyAuth?

  private var urlSearch = ""

  private let marginMessageBox: CGFloat = 20

  public var isTokenValid: Bool {
    guard let spotifyAuth = spotifyAuth else { return false }
    return spotifyAuth.isValid
  }

  public func getAuth(completionHandler:@escaping (Result<SpotifyAuth>) -> Void) {

    self.getDataWith(urlString: SpotifyKeys.authURL.rawValue, type: .authentification, completion: { (result) in
      switch result {
      case .success(let data):
        ParserService<SpotifyAuth>.parse(data, completionHandler: { (result) in
        switch result {
        case .success(let auth):
          guard let auth = auth  else {
            completionHandler(.error("Returned object is not SpotifyAuth type"))
            return
          }
          UserDefaultsService.saveObject(auth)
          completionHandler(.success(auth))
        case .failure(_, let message):
          completionHandler(.error(message))
        }
        })

      case .error(let message):
        ErrorService.sharedInstance.showErrorMessage(message: message)
        completionHandler(.error(message))
      }
    })
  }

  public func getArtistsList(artistName: String, completionHandler: @escaping (Result<[Artist]>) -> Void) {

    let searchArtistURL = "\(SpotifyKeys.uri.rawValue)search?q=\(artistName.urlEncoded())&type=artist"
    self.getDataWith(urlString: searchArtistURL, type: .searchArtists, completion: { (result) in
      switch result {
      case .success(let data):
        ParserService<SearchArtistsRoot>.parse(data, completionHandler: { (result) in
          switch result {
          case .success(let searchArtistsRoot):
            guard let artists = searchArtistsRoot?.artists.items  else {
              completionHandler(.error("Returned object is not an array of Artist type"))
              return
            }
            completionHandler(.success(artists))
          case .failure(_, let message):
            completionHandler(.error(message))
          }
        })

      case .error(let message):
        ErrorService.sharedInstance.showErrorMessage(message: message)
        completionHandler(.error(message))
      }
    })

  }

  public func cancelRequests() {
    URLSession.shared.getTasksWithCompletionHandler { (dataTask, uploadTask, downloadTask) in
      for task in dataTask {
        task.cancel()
      }
      for task in uploadTask {
        task.cancel()
      }
      for task in downloadTask {
        task.cancel()
      }
      NetworkActivityService.sharedInstance.disableActivityIndicator()
    }
  }

  private func getDataWith(urlString: String, type: TypeWebService, completion: @escaping (Result<Data>) -> Void) {
    guard let url = URL(string: urlString) else { return completion(.error("Invalid URL, we can't update your feed")) }
    var request = URLRequest(url: url)
    switch type {
    case .authentification:
      request.httpMethod = "POST"
      let bodyParams = "grant_type=client_credentials"
      request.httpBody = bodyParams.data(using: String.Encoding.ascii, allowLossyConversion: true)
      let base64Key = "\(SpotifyKeys.clientID.rawValue):\(SpotifyKeys.secret.rawValue)".toBase64()
      request.addValue("Basic \(base64Key)", forHTTPHeaderField: "Authorization")
    case .searchArtists:
      request.httpMethod = "GET"
      guard let accessToken = spotifyAuth?.accessToken else { return }
      request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }

    NetworkActivityService.sharedInstance.newRequestStarted()
    URLSession.shared.dataTask(with: request) { (data, _, error) in
      DispatchQueue.main.async {
        NetworkActivityService.sharedInstance.requestFinished()
        guard error == nil else {
          return completion(.error(error!.localizedDescription)) }
        guard let data = data else { return completion(.error(error?.localizedDescription ?? "Error from network not identified")) }
        return completion(.success(data))
      }
      }.resume()
  }

  private init() {
    spotifyAuth = UserDefaultsService.getObject()
    ReachabilityService.sharedInstance.delegates.add(self)
  }

  deinit {
    ReachabilityService.sharedInstance.delegates.remove(self)
  }

  private func displayNetworkStatus() {
    let view = MessageView.viewFromNib(layout: .cardView)
    switch onlineMode {
    case .offline:
      view.configureTheme(.warning)
      view.configureContent(title: L10n.errorTitle, body: L10n.errorUnavailableNetwork)
    case .onlineSlow:
      view.configureTheme(.warning)
      view.configureContent(title: L10n.errorTitle, body: L10n.badNetworkMessage)
    case .online:
      view.configureTheme(.success)
      view.configureContent(title: L10n.okTitle, body: L10n.networkAvailableMessage)
    }
    SwiftMessages.show {
      view.configureDropShadow()
      view.button?.isHidden = true
      view.layoutMarginAdditions = UIEdgeInsets(top: self.marginMessageBox, left: self.marginMessageBox, bottom: self.marginMessageBox, right: self.marginMessageBox)
      (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
      return view
    }
  }
}

// MARK: - ReachabilityManagerDelegate
extension WebServiceService: ReachabilityServiceDelegate {

  public func onlineModeChanged(_ newMode: OnlineMode) {
    if onlineMode != newMode {
      onlineMode = newMode
      displayNetworkStatus()
    }
  }
}
