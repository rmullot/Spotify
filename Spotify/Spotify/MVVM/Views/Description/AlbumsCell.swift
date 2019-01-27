//
//  AlbumsCell.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class AlbumsCell: UICollectionViewCell {

  static let heightDefault: CGFloat = 160.0

  @IBOutlet weak var collectionView: UICollectionView!

  weak var viewModel: AlbumsViewModel! {
    didSet {
      collectionView.reloadData()
    }
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

  }

  override func awakeFromNib() {
    collectionView.registerReusableCell(AlbumCell.self)
    collectionView.isHidden = true
  }

}
