//
  //  MainCoordinator.swift
  //  Spotify
  //
  //  Created by Romain Mullot on 27/01/2019.
  //  Copyright © 2019 Romain Mullot. All rights reserved.
  //

  import Foundation
  import UIKit
  import SpotifyCore

  protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }

    func start()
  }

  extension Coordinator {
    var navigationController: UINavigationController {
        guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
          fatalError()
        }
        return navigationController
    }

  }

  class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()

    func start() {
      let searchViewController = SearchViewController.initFromNib()
      searchViewController.viewModel.coordinator = self
      navigationController.pushViewController(searchViewController, animated: false)
    }

    func displayDescription(artist: Artist) {
      let descriptionViewController = DescriptionViewController.initFromNib()
      let viewModel = DescriptionViewModel(artist: artist)
      viewModel.coordinator = self
      descriptionViewController.viewModel = viewModel
      navigationController.pushViewController(descriptionViewController, animated: true)
    }
  }
