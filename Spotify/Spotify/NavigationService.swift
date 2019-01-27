//
//  NavigationService.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import Foundation
import UIKit
import SpotifyCore

protocol NavigationServiceProtocol {
  func navigateToDescription(artist: Artist)
}

final class NavigationService: NavigationServiceProtocol {

  // MARK: - Attributes

  static let sharedInstance = NavigationService()

  private var navigationController: UINavigationController {
    guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
      fatalError()
    }
    return navigationController
  }

  // MARK: - Methods

  func navigateToDescription(artist: Artist) {
    guard navigationController.visibleViewController is SearchViewController  else { return }
    let descriptionViewController = DescriptionViewController.initFromNib()
    descriptionViewController.viewModel = DescriptionViewModel(artist: artist)
    navigationController.pushViewController(descriptionViewController, animated: true)
  }

  // MARK: - Private Methods

  private init() {}
}
