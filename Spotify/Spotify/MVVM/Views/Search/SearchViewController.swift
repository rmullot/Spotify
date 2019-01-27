//
//  SearchViewController.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit
import SpotifyUI

final class SearchViewController: BaseViewController<SearchViewModel>, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!

  private let refreshControl = UIRefreshControl()

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.propertyChanged = { [weak self] key in self?.viewModelPropertyChanged(key) }
    viewModel.artistsDidChange = { [weak self] viewModel in
      self?.refreshControl.endRefreshing()
      self?.tableView.reloadData()
    }
    tableView.accessibilityIdentifier = UITestingIdentifiers.searchViewController.rawValue
    searchBar.accessibilityIdentifier = UITestingIdentifiers.searchBar.rawValue
    searchBar.accessibilityTraits = UIAccessibilityTraits.searchField

    title = "Spotify"

    tableView.registerReusableCell(ArtistCell.self)
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

  }

  private func viewModelPropertyChanged(_ key: String) {
    switch key {
    case SearchViewModel.PropertyKeys.errorMessage.rawValue:
      messageLabel.text = viewModel.errorMessage
    default:
      break
    }
  }

  @objc private func refresh(_ sender: Any) {
    viewModel.getArtistsInformations(searchKeyWord: searchBar.text ?? "")
  }

  // MARK: - UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tableView.isHidden = viewModel.noResults
    if viewModel.noResults {
      viewModel.rebootStatusMessage()
    }
    return viewModel.artistsCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(ArtistCell.self, indexPath: indexPath)
    cell.viewModel = viewModel.getArtistViewModel(index: indexPath.row)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }

  // MARK: - UITableViewDelegate

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.displayDescription(index: indexPath.row)
  }

  // MARK: - UISearchBarDelegate

  func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    return viewModel.isValidSearch(text)
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.rebootStatusMessage()
    searchBar.resignFirstResponder()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.getArtistsInformations(searchKeyWord: searchBar.text ?? "")
    searchBar.resignFirstResponder()
  }
}
