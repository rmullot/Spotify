//
//  ArtistHeader.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class ArtistHeader: UICollectionReusableView {

  private let placeholder = UIImage(named: "placeholder")

  static let heightDefault: CGFloat = 100.0

  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageview: UIImageView!

  weak var viewModel: ArtistViewModel! {
    didSet {
      self.photoImageview.loadImageWithUrl(viewModel.getImageURL(width: Int(self.photoImageview.frame.size.width)), placeHolder: placeholder)
      self.nameLabel.text = viewModel.name
      self.genreLabel.text = viewModel.genres
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageview.image = placeholder
    nameLabel.text = ""
    genreLabel.text = ""
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
