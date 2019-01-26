//
//  ArtistCell.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class ArtistCell: UITableViewCell {

    static let cellID = "ForecastInfoCellID"

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageview: UIImageView!

    weak var viewModel: ArtistViewModel! {
        didSet {
            self.photoImageview.loadImageWithUrl(viewModel.imageURL, placeHolder: UIImage(named: "placeholder"))
            self.nameLabel.text = viewModel.name
            self.genreLabel.text = viewModel.genres
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }

}
