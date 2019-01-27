//
//  AlbumCell.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class AlbumCell: UICollectionViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageview: UIImageView!

  private let placeholder = UIImage(named: "placeholder")

  weak var viewModel: AlbumViewModel! {
    didSet {
      self.photoImageview.loadImageWithUrl(viewModel.getImageURL(width: Int(self.photoImageview.frame.size.width)), placeHolder: placeholder)

      self.nameLabel.text = viewModel.name
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageview.image = placeholder
    nameLabel.text = ""
  }

}
