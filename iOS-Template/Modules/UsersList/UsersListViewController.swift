//
//  UsersListViewController.swift
//  iOS-Template
//
//  Created by apple on 27/05/21.
//

import UIKit

final class UsersListViewController: UIViewController {
  
  private var listView: UICollectionView!
  private var usersDataSource: GitHubUsersDataSource!
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.listView = UICollectionView(frame: .zero, collectionViewLayout: .insetGroupedListLayout)
    let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { [weak self] (cell, _, userID) in
      guard let item = self?.usersDataSource?[userID] else { return }
      var configuration = cell.defaultContentConfiguration()
      configuration.text = item.login
      cell.contentConfiguration = configuration
    }
    let diffableDataSource = GitHubUsersDataSource(collectionView: listView, cellProvider: { (collectionView, indexPath, userID) -> UICollectionViewCell? in
      collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: userID)
    })
    self.usersDataSource = diffableDataSource
    addPlaceholderData()
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = listView
  }
  
  private func makeCollectionViewLayout() -> UICollectionViewLayout {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    listConfiguration.headerMode = .none
    let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    return layout
  }
  
  private func addPlaceholderData() {
    usersDataSource.replaceExistingUsers(with: .placholderList)
  }
  
}

extension UICollectionViewLayout {
  
  static var insetGroupedListLayout: UICollectionViewCompositionalLayout {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    listConfiguration.headerMode = .none
    let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    return layout
  }
  
}
