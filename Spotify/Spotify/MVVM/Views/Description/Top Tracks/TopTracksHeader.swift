//
//  TopTracksHeader.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

class TopTracksHeader: UITableViewHeaderFooterView {

  @IBOutlet weak var titleLabel: UILabel!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
