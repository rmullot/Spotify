//
//  TopTracksCell.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class TopTracksCell: UICollectionViewCell {

  private let heightTopTracksHeader: CGFloat = 40.0
  private let heightFooter: CGFloat = 1.0
  private let heightOtherHeaders: CGFloat = 1.0

  @IBOutlet weak var tableview: UITableView!

  var viewModel: TopTracksViewModel! {
    didSet {
      tableview.isHidden = self.viewModel.noResults
      //TODO: add message error
      //    if viewModel.noResults {
      //      viewModel.rebootStatusMessage()
      //    }
      tableview.reloadData()
      tableview.setNeedsLayout()
      UIView.animate(withDuration: 0.5, animations: {
        self.tableview.layoutIfNeeded()
      }, completion: { (_) in
        var heightOfTableView: CGFloat = self.heightTopTracksHeader
        // Get visible cells and sum up their heights
        self.tableview.visibleCells.forEach({ cell in
          heightOfTableView += cell.frame.height
        })
        heightOfTableView += self.heightFooter
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
    return heightTopTracksHeader
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return heightFooter
  }

}

// MARK: - UITableViewDelegate

extension TopTracksCell: UITableViewDelegate {

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard section == 0 else { return UIView() }
    return tableView.dequeueReusableView(TopTracksHeader.self)
  }

}
