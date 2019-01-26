//
//  UIViewController+Spotify.swift
//  SpotifyUI
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

extension UIViewController {

  public static func initFromNib() -> Self {
    func loadFromNib<T: UIViewController>() -> T {
      return T(nibName: String(describing: self), bundle: nil)
    }
    return loadFromNib()
  }
}
