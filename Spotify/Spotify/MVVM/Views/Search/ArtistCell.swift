//
//  ArtistCell.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class ArtistCell: UITableViewCell {

    static let cellID = "ArtistCell"

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageview: UIImageView!

    weak var viewModel: ArtistViewModel! {
        didSet {
            self.photoImageview.loadImageWithUrl(viewModel.getImageURL(width: Int(self.photoImageview.frame.size.width)), placeHolder: UIImage(named: "placeholder"))
            self.nameLabel.text = viewModel.name
            self.genreLabel.text = viewModel.genres
        }
    }

  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageview.image = UIImage(named: "placeholder")
    nameLabel.text = ""
    genreLabel.text = ""
  }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

}
