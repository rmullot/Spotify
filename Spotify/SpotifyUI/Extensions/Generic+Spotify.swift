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

extension UITableView {

  public func registerReusableCell<T: UITableViewCell>(_: T.Type) {
    self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
  }

  public func dequeueReusableCell<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
  }
}
