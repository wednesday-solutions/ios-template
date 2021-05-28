//
//  UsersListViewController.swift
//  iOS-Template
//
//  Created by apple on 27/05/21.
//

import Combine
import UIKit

final class UsersListViewController: UIViewController, UICollectionViewDelegate {
  
  private var listView: UICollectionView!
  private var usersDataSource: GitHubUsersDataSource!
  private var cancellables = Set<AnyCancellable>()
  private let networkingController = NetworkingController()
  private weak var userSelectionHandler: UserSelectionHandling?
  
  init(userSelectionHandler: UserSelectionHandling? = nil) {
    self.userSelectionHandler = userSelectionHandler
    super.init(nibName: nil, bundle: nil)
    self.listView = UICollectionView(frame: .zero, collectionViewLayout: .insetGroupedListLayout)
    listView.delegate = self
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
    let searchController = UISearchController(searchResultsController: nil)
    title = "GitHub User Search"
    searchController.definesPresentationContext = true
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    observeSearchTextChanges(
      searchField: searchController.searchBar.searchTextField,
      onSearchResults: { [weak dataSource = diffableDataSource] (result) in
        switch result {
        case .success(let users): dataSource?.replaceExistingUsers(with: users)
        case .failure(let error): print(error)
        }
      }
    )
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = listView
  }
  
  private func observeSearchTextChanges(
    searchField: UISearchTextField,
    onSearchResults callback: @escaping (Result<[GithubUser], NetworkingError>) -> Void
  ) {
    NotificationCenter.default.publisher(
      for: UISearchTextField.textDidChangeNotification,
      object: searchField
    )
    .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
    .compactMap {
      switch ($0.object as? UISearchTextField)?.text {
      case .none: return nil
      case .some(let text) where text.isEmpty: return nil
      case .some(let text): return text
      }
    }
    .removeDuplicates()
    .setFailureType(to: NetworkingError.self)
    .flatMap { [networkingController] in
      networkingController.usersPublisher(query: $0)
    }
    .receive(on: RunLoop.main)
    .asResult()
    .sink(receiveValue: callback)
    .store(in: &cancellables)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let user = usersDataSource[indexPath]
    userSelectionHandler?.didSelect(user: user)
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
