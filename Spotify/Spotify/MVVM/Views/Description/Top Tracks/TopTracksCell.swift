//
//  TopTracksCell.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class TopTracksCell: UICollectionViewCell {

  private let heightFirstHeader: CGFloat = 63.0
  private let heightFooter: CGFloat = 1.0
  private let heightLastFooter: CGFloat = 10.0
  private let heightOtherHeaders: CGFloat = 33.0

  @IBOutlet weak var tableview: UITableView!

  var viewModel: TopTracksViewModel! {
    didSet {
      tableview.reloadData()
      tableview.setNeedsLayout()
      UIView.animate(withDuration: 0.5, animations: {
        self.tableview.layoutIfNeeded()
      }, completion: { (_) in
        var heightOfTableView: CGFloat = self.heightFirstHeader
        // Get visible cells and sum up their heights
        self.tableview.visibleCells.forEach({ cell in
          heightOfTableView += cell.frame.height + self.heightOtherHeaders + self.heightFooter
        })
        heightOfTableView += self.heightLastFooter
        // Edit heightOfTableViewConstraint's constant to update height of table view
        self.viewModel.updateTopTracks(heightTopTracks: Float(heightOfTableView))
      })
    }
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

  }

  override func awakeFromNib() {
    tableview.registerReusableCell(TrackCell.self)
    tableview.registerReusableView(TopTracksHeader.self)
    tableview.isHidden = true
  }

}

// MARK: - UITableViewDataSource
extension TopTracksCell: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tableView.isHidden = viewModel.noResults
    //TODO: add message error
    //    if viewModel.noResults {
    //      viewModel.rebootStatusMessage()
    //    }
    return viewModel.tracksCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(TrackCell.self, indexPath: indexPath)
    cell.viewModel = viewModel.getTrackViewModel(index: indexPath.row)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? heightFirstHeader : heightOtherHeaders
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return section == viewModel.tracksCount - 1 ? heightLastFooter : 1
  }

}

// MARK: - UITableViewDelegate
extension TopTracksCell: UITableViewDelegate {

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard section == 0 else {
      return UIView()
    }
    return tableView.dequeueReusableView(TopTracksHeader.self)
  }

}
