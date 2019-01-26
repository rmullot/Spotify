//
//  SearchViewController.swift
//  Spotify
//
//  Created by Romain Mullot on 26/01/2019.
//  Copyright © 2019 Romain Mullot. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!

  private var viewModel = SearchViewModel()

  private let refreshControl = UIRefreshControl()

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.propertyChanged = { [weak self] key in self?.viewModelPropertyChanged(key) }

    messageLabel.layer.shadowColor = UIColor.black.cgColor
    messageLabel.layer.shadowRadius = 1.0
    messageLabel.layer.shadowOpacity = 1.0
    messageLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
    messageLabel.layer.masksToBounds = false

    self.tableView.accessibilityIdentifier = UITestingIdentifiers.searchViewController.rawValue
    self.title = "Spotify"
    self.tableView.register(UINib(nibName: "ArtistCell", bundle: nil), forCellReuseIdentifier: ArtistCell.cellID)
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
  }

  private func viewModelPropertyChanged(_ key: String) {
    switch key {
    case SearchViewModel.PropertyKeys.statusMessage.rawValue:
      messageLabel.text = viewModel.statusMessage
    default:
      break
    }
  }

  @objc private func refresh(_ sender: Any) {
    viewModel.getArtistsInformations(searchKeyWord: searchBar.text ?? "")
  }

}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

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
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.artistsCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.cellID, for: indexPath) as? ArtistCell {
      cell.viewModel = viewModel.getArtistViewModel(index: indexPath.row)
      return cell
    }
    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }

}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
}
