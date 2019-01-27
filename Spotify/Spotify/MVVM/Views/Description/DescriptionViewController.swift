//
//  DescriptionViewController.swift
//  Spotify
//
//  Created by Romain Mullot on 27/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit
import SpotifyCore

final class DescriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  fileprivate enum DescriptionTypeCell: Int {
    case topTracks
    case albums

    static let count: Int = {
      var max: Int = 0
      while let _ = DescriptionTypeCell(rawValue: max) { max += 1 }
      return max
    }()
  }

  @IBOutlet weak var collectionView: UICollectionView!
  private var heightMenuTopTracks: CGFloat = 1000.0

  var viewModel: DescriptionViewModel! {
    didSet {
      self.viewModel.albumsDidChange = { [weak self] viewModel in
        self?.collectionView?.reloadData()
        self?.refreshLayout(animation: true)
      }

      self.viewModel.updateDescriptionContent()
    }
  }

  func refreshLayout(animation: Bool = false) {
    let duration = animation ? 0.5 :0.0
    UIView.animate(withDuration: duration) {
      self.collectionView?.collectionViewLayout.invalidateLayout()
      self.collectionView?.layoutIfNeeded()
    }
  }

  override func viewDidLoad() {
    self.collectionView?.accessibilityIdentifier = UITestingIdentifiers.descriptionViewController.rawValue
    super.viewDidLoad()
    self.collectionView?.contentInsetAdjustmentBehavior = .never
    self.collectionView?.backgroundColor = .white
    self.collectionView?.registerReusableCell(AlbumsCell.self)
    self.collectionView?.registerReusableCell(TopTracksCell.self)
    self.collectionView?.registerReusableHeader(ArtistHeader.self)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
    WebServiceService.sharedInstance.cancelRequests()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row {
    case DescriptionTypeCell.topTracks.rawValue:
      let cell = self.collectionView.dequeueReusableCell(TopTracksCell.self, indexPath: indexPath)
      cell.viewModel = viewModel.getTopTracksViewModel()
      cell.viewModel.topTracksDidChange = { [weak self] (viewModel, height) in
        self?.heightMenuTopTracks = CGFloat(height)
        self?.refreshLayout(animation: true)
      }
      return cell
    case DescriptionTypeCell.albums.rawValue:
      let cell = self.collectionView.dequeueReusableCell(AlbumsCell.self, indexPath: indexPath)
      cell.viewModel = self.viewModel.getAlbumsViewModel()
      return cell
    default:
      break
    }
    return UICollectionViewCell()

  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return DescriptionTypeCell.count
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let header = collectionView.dequeueReusableHeader(ArtistHeader.self, indexPath: indexPath)
      header.viewModel = viewModel.getArtistViewModel()
      return header
    }
    return UICollectionReusableView()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.size.width, height: ArtistHeader.heightDefault)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    collectionView?.collectionViewLayout.invalidateLayout()
    super.viewWillTransition(to: size, with: coordinator)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DescriptionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var size = CGSize.zero
    if indexPath.row < DescriptionTypeCell.count {
      let width = UIScreen.main.bounds.size.width
      switch indexPath.row {
      case DescriptionTypeCell.topTracks.rawValue:
        if heightMenuTopTracks == 0 {
          heightMenuTopTracks = 1000.0
        }
        size = CGSize(width: width, height: heightMenuTopTracks)
      case DescriptionTypeCell.albums.rawValue:
        size = CGSize(width: width, height: AlbumsCell.heightDefault)
      default:
        break
      }
    }
    return size
  }

}
