//
//  TrackCell.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class TrackCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!

  weak var viewModel: TrackViewModel! {
    didSet {
      self.nameLabel.text = viewModel.name
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
