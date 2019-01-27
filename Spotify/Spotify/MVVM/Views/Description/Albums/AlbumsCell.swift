//
//  AlbumsCell.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

final class AlbumsCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

  static let heightDefault: CGFloat = 175.0

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!

  var viewModel: AlbumsViewModel! {
    didSet {
      collectionView.isHidden = viewModel.noResults
      pageControl.numberOfPages = viewModel.albumsCount
      configCurrentPage()
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

  // MARK: - UICollectionViewDataSource

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = self.collectionView.dequeueReusableCell(AlbumCell.self, indexPath: indexPath)
      cell.viewModel = viewModel.getAlbumViewModel(index: indexPath.row)
      return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.albumsCount
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    configCurrentPage()
  }

  private func configCurrentPage() {
    if let indexPath = collectionView.indexPathsForVisibleItems.first {
      pageControl.currentPage = indexPath.row
    }
  }

}
